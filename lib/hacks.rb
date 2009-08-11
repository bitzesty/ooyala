# module HTTParty
#   class Request #:nodoc:
#      def uri
#         new_uri = path.relative? ? URI.parse("#{options[:base_uri]}#{path}") : path
# 
#         # avoid double query string on redirects [#12]
#         unless @redirect
#           new_uri.query = query_string(new_uri)
#         end
#         puts new_uri
#         new_uri
#       end
#   end
# end
    
# Need to hack httparty' perform request
# http://github.com/jnunemaker/httparty/blob/b0cf1e946f483b882f9fe4142b768754dbce6657/lib/httparty.rb#L157
# to conform with the api http://www.ooyala.com/support/docs/partner_api
module HTTParty
  module ClassMethods
  private
    def perform_request(http_method, path, options)
      process_cookies(options)
      string_to_sign = ooyala_options[:api_codes][:secret]
      
      options[:query] ||= {}
      options[:query]["expires"] ||= (Time.now.to_i + 5).to_s
      
      q = ["pcode=#{ooyala_options[:api_codes][:partner]}"]
      options[:query].keys.sort.each do |k|
        string_to_sign += "#{k}=#{options[:query][k]}"
        q << "#{CGI.escape(k)}=#{CGI.escape(options[:query][k])}"
      end
      
      digest = Digest::SHA256.digest(string_to_sign)
      signature = Base64::encode64(digest).chomp.gsub(/=+$/, '')
      q << "signature=#{signature}"
      options[:query] = q.join("&")
      
      Request.new(http_method, path, default_options.dup.merge(options)).perform
    end
  end
end
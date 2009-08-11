require 'rubygems'
require 'httparty'
require 'httparty/module_inheritable_attributes'
require "base64"
require "digest/sha2"
require 'uri'
require 'hacks'

module Ooyala
  class NoAPICodes < StandardError; end #:nodoc:
  class NoEmmbedCode < StandardError;end #:nodoc:
  class InvalidStatus < StandardError;end #:nodoc:
  class InvalidAction < StandardError;end #:nodoc:
  
  def self.included(base)
    base.send :include, HTTParty
    base.extend ClassMethods
    base.send(:mattr_inheritable, :ooyala_options)
    base.instance_variable_set("@ooyala_options", {})
    base.send(:base_uri, "http://api.ooyala.com/partner/")
  end
  
  module ClassMethods
    def api_codes(partner, secret)
      raise NoAPICodes if partner.blank? || secret.blank?
      ooyala_options[:api_codes] = {:partner => partner, :secret => secret}
    end
    
    def query(options={})
      self.get("/query", :query => options)
    end
    
    ##
    # Options:
    # rage:: String:: "0-4"
    # resolution:: String:: "320x240" 
    def thumbnails(embed_code, options={})
      raise NoEmmbedCode if embed_code.blank?
      opts = {"embedCode" => embed_code, "range" =>"0-25", "resolution" =>"600x400"}.merge(options)      
      self.get("/thumbnails", :query  => opts)
    end
    
    ##
    # TODO make an instance method
    # Options:
    # title:: String
    # description:: String
    # status:: String - "live", "paused" or "deleted" - Setting status to deleted deletes the video or channel.
    # hostedAt:: String - The URL for the main page the video or channel is embedded on. 
    def edit(embed_code, options={})
      raise NoEmmbedCode if embed_code.blank?
      status_options = ['live', 'paused', 'deleted']
      if options["status"]
        raise InvalidStatus unless status_options.include?(options["status"])
      end
      opts = {"embedCode" => embed_code}.merge(options)
      self.get("/edit", :query => opts)
    end
    
    ##
    # TODO make an instance method
    # Actions:: ["add", "query", "delete_id", "delete_query"]
    # Add opts:: director, actor, genre (multiple in an array)
    # Search opts:: rows, op (OR, AND), and same as Add action but with asterisks for fuzzy searching
    # Delete ID opts:: guid
    # Delete Query opts:: same as search (delete metadata)
    def metadata(embed_code, action, options={})
      raise NoEmmbedCode if embed_code.blank?
      raise InvalidAction unless ["add", "query", "delete_id", "delete_query"].include?(action)
      if options["genre"].is_a?(Array)
        options["genre"] = options["genre"].join("\0")
      end
      opts = {"embedCode" => embed_code, "metaMode" => action}.merge(options)
      self.get("/metadata", :query => opts)
    end
  end

end
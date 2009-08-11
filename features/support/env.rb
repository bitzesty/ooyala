$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'ooyala'

require 'spec/expectations'

# require 'fakeweb' #http://fakeweb.rubyforge.org/
require 'pp'
require "yaml"

API = YAML::load_file(File.dirname(__FILE__) + '/api.yml')

class Video
  include Ooyala
  api_codes API["partner_code"], API["secret_code"]
end
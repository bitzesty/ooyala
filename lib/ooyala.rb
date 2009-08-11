require 'rubygems'
require 'httparty'
require 'httparty/module_inheritable_attributes'
require "base64"
require "digest/sha2"
require 'uri'
require 'hacks'

module Ooyala
  class NoAPICodes < StandardError; end
  class NoEmmbedCode < StandardError;end
  
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
    
    def query(o={})
      self.get("/query", o)
    end
    
    def thumbnails(embed_code, range="0-25", resolution="600x400")
      raise NoEmmbedCode if embed_code.blank?
      self.get("/thumbnails", :query  => {"embedCode" => embed_code, "range" => range, "resolution" => resolution})
    end
  end

end
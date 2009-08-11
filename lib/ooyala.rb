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
  class InvalidStatus < StandardError;end
  
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
      self.get("/query", :query => o)
    end
    
    def thumbnails(embed_code, options={})
      raise NoEmmbedCode if embed_code.blank?
      opts = {"embedCode" => embed_code, "range" =>"0-25", "resolution" =>"600x400"}.merge(options)      
      self.get("/thumbnails", :query  => opts)
    end
    
    # this is a get - note sure why it's not a put or at least an overloaded post
    def edit(embed_code, options={})
      raise NoEmmbedCode if embed_code.blank?
      status_options = ['live', 'paused', 'deleted']
      if options["status"]
        raise InvalidStatus unless status_options.include?(options["status"])
      end
      opts = {"embedCode" => embed_code}.merge(options)
      self.get("/edit", :query => opts)
    end
  end

end
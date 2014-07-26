ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require 'fabrication'
require_relative '../config/application'
Dir[File.join(Whois.root, 'spec', 'support', '**/*.rb')].each { |file| require File.expand_path(file) }

SchemaLoad.new.perform

include Rack::Test::Methods

def app
  Whois::Application
end
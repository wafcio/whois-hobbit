require 'hobbit'
require 'sequel'
require 'sqlite3'
require 'whois'

ENV['RACK_ENV'] ||= 'development'

module Whois
  def self.root
    @@root ||= __FILE__.to_s.gsub!('config/application.rb', '')
  end

  def self.env
    ENV['RACK_ENV']
  end

  class Application < Hobbit::Base
    Dir[File.join(Whois.root, 'config', 'initializers', '**/*.rb')].each { |file| require File.expand_path(file) }
    Dir[File.join(Whois.root, 'app', 'models', '**/*.rb')].each { |file| require File.expand_path(file) }
  end
end

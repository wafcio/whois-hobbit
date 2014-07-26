require 'sequel'
require 'sqlite3'
require 'sprockets'
require 'whois'

module Whois
  def self.root
    @@root ||= __FILE__.to_s.gsub!('config/load.rb', '')
  end

  def self.env
    ENV['RACK_ENV']
  end
end

Dir[File.join(Whois.root, 'config', 'initializers', '**/*.rb')].each { |file| require File.expand_path(file) }
Dir[File.join(Whois.root, 'app', 'models', '**/*.rb')].each { |file| require File.expand_path(file) }
require 'sequel'
require 'pg'
require 'sprockets'
require 'whois'

if ENV['RACK_ENV'] == 'development'
  require 'sqlite3'
end

module Whois
  def self.root
    @@root ||= __FILE__.to_s.gsub!('config/load.rb', '')
  end

  def self.env
    ENV['RACK_ENV'] || 'development'
  end
end

require File.join(Whois.root, 'lib', 'sprockets_environment')

Dir[File.join(Whois.root, 'config', 'initializers', '**/*.rb')].each { |file| require File.expand_path(file) }
Dir[File.join(Whois.root, 'app', 'models', '**/*.rb')].each { |file| require File.expand_path(file) }
Dir[File.join(Whois.root, 'app', 'services', '**/*.rb')].each { |file| require File.expand_path(file) }
module Whois
  def self.root
    @@root ||= Pathname(File.dirname(__FILE__)).parent
  end

  def self.env
    ENV['RACK_ENV'] || 'development'
  end
end

patterns = [
  Whois.root.join('config', 'initializers', '**', '*.rb')
]

Dir.glob(patterns).each { |file| require File.expand_path(file) }

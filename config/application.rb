require 'hobbit'

module Whois
  def self.root
    @@root ||= __FILE__.to_s.gsub!('config/application.rb', '')
  end

  class Application < Hobbit::Base
  end
end

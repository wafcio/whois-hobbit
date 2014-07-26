require 'hobbit'
require 'hobbit/render'
require_relative 'load'

ENV['RACK_ENV'] ||= 'development'

module Whois
  class Application < Hobbit::Base
    Dir[File.join(Whois.root, 'app', 'controllers', '**/*.rb')].each { |file| require File.expand_path(file) }

    map '/assets' do
      environment = Sprockets::Environment.new
      AppConfig.sprocktes[:path].each do |path|
        environment.append_path(path)
      end
      run environment
    end

    map('/') { run RootController.new }
  end
end

require 'hobbit'
require 'hobbit/render'
require 'hobbit/session'
require 'rack/protection'
require 'securerandom'
require 'omniauth'
require 'omniauth-github'
require 'omniauth-google-oauth2'

require_relative 'load'

module Whois
  class Application < Hobbit::Base
    Dir[File.join(Whois.root, 'app', 'controllers', '**/*.rb')].each { |file| require File.expand_path(file) }

    use Rack::Session::Cookie, secret: SecureRandom.hex(64)
    use Rack::Protection, except: :http_origin
    use Rack::MethodOverride

    use OmniAuth::Builder do
      provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET']
    end

    map '/assets' do
      environment = Sprockets::Environment.new
      AppConfig.sprocktes[:path].each do |path|
        environment.append_path(path)
      end
      run environment
    end

    map('/') { run RootController.new }
    map('/domains') { run DomainsController.new }
  end
end

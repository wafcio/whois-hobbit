require 'hobbit'
require 'hobbit/render'
require 'hobbit/session'
require 'hobbit/session'
require 'hobbit/filter'
require 'rack/protection'
require 'securerandom'
require 'omniauth'
require 'omniauth-github'

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
      run SprocketsEnvironment.new.environment
    end

    map('/') { run RootController.new }
    map('/domains') { run DomainsController.new }
  end
end

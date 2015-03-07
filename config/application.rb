require_relative 'environment'

require 'hobbit'
require 'hobbit/render'
require 'rack/classy_assets'
require 'haml'
require 'sass'

module Whois
  class Application < Hobbit::Base
    use Rack::ClassyAssets

    include Hobbit::Render

    get '/' do
      render 'home'
    end

    private

    def template_engine
      'haml'
    end

    def views_path
      'app/views'
    end
  end
end

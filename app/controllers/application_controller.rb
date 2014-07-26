class Whois::ApplicationController < Whois::Application
  include Hobbit::Render

  def template_engine
    'haml'
  end

  def layouts_path
    'app/views/layouts'
  end
end
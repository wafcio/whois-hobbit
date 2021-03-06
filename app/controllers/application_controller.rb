class Whois::ApplicationController < Whois::Application
  include Hobbit::Render
  include Hobbit::Session
  include Hobbit::Filter

  def template_engine
    'haml'
  end

  def layouts_path
    'app/views/layouts'
  end

  def current_user
    @current_user ||= User.with_pk(session[:user_id])
  end

  def authenticate
    unless current_user
      response.redirect '/sign_in'
      halt response.finish
    end
  end
end
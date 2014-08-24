require_relative 'application_controller'

class Whois::RootController < Whois::ApplicationController
  def views_path
    'app/views/'
  end

  get '/' do
    response.redirect(redirect_on_root)
  end

  get '/sign_in' do
    render 'sessions/new', {}, layout: false
  end

  get '/logout' do
    session[:user_id] = nil
    response.redirect '/sign_in'
  end

  post '/session' do
    if authenticate
      redirect_to_root
    else
      render_sessions_new
    end
  end

  get '/auth/:provider/callback' do
    session[:user_id] = omniauth_user.id
    redirect_to_root
  end

  get '/auth/failure' do
    redirect_to_root
  end

  def redirect_on_root
    current_user ? '/domains' : '/sign_in'
  end

  def omniauth_user
    OmniauthUser.new(request.env['omniauth.auth']).user
  end

  def redirect_to_root
    response.redirect '/'
  end

  def authenticate
    if condition = load_user_by_email && load_user_by_email.authenticate(request.params['password'])
      session[:user_id] = load_user_by_email.id
    end

    condition
  end

  def load_user_by_email
    @load_user_by_email ||= User.find(email: request.params['email'])
  end

  def render_session_new
    render 'sessions/new', {}, layout: false
  end
end
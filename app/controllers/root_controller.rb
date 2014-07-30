require_relative 'application_controller'

class Whois::RootController < Whois::ApplicationController
  def views_path
    'app/views/'
  end

  get '/' do
    response.redirect(current_user ? '/domains' : '/sign_in')
  end

  get '/sign_in' do
    render 'sessions/new', {}, layout: false
  end

  get '/logout' do
    session[:user_id] = nil
    response.redirect '/sign_in'
  end

  post '/session' do
    user = User.find(email: request.params['email'])
    if user && user.authenticate(request.params['password'])
      session[:user_id] = user.id
      response.redirect '/'
    else
      render 'sessions/new', {}, layout: false
    end
  end

  get '/auth/:provider/callback' do
    omniauth_user = OmniauthUser.new(request.env['omniauth.auth'])
    session[:user_id] = omniauth_user.user.id
    response.redirect '/'
  end

  get '/auth/failure' do
    response.redirect '/'
  end
end
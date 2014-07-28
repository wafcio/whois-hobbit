class Whois::RootController < Whois::ApplicationController
  def views_path
    'app/views/'
  end

  get '/' do
    response.redirect(current_user ? '/domains' : '/login')
  end

  get '/login' do
    render 'sessions/new', {}, layout: false
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
end
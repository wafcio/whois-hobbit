class Whois::RootController < Whois::ApplicationController
  def views_path
    'app/views/'
  end

  get '/' do
    response.redirect '/login'
  end

  get '/login' do
    render 'sessions/new', {}, layout: false
  end
end
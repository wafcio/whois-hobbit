class Whois::DomainsController < Whois::ApplicationController
  def views_path
    'app/views/domains'
  end

  get '/' do
    authenticate
    unless response.status == 302
      @domains = Domain.where(user_id: current_user.id).order(:expires_on)
      render 'index'
    end
  end

  get '/new' do
    authenticate
    unless response.status == 302
      @domain = Domain.new(user: current_user)
      render 'new'
    end
  end

  post '/' do
    authenticate
    unless response.status == 302
      @domain = Domain.new(user: current_user, name: request.params['domain'])
      if @domain.valid?
        @domain.save
        response.redirect '/domains'
      else
        render 'new'
      end
    end
  end

  delete '/:id' do
    authenticate
    unless response.status == 302
      domain = Domain.find(id: request.params[:id], user_id: current_user.id)
      domain.delete if domain
      response.redirect '/domains'
    end
  end

  get '/:id/refresh' do
    authenticate
    unless response.status == 302
      domain = Domain.find(id: request.params[:id], user_id: current_user.id)
      domain.update_whois
      response.redirect '/domains'
    end
  end
end
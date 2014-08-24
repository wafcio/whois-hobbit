require_relative 'application_controller'

class Whois::DomainsController < Whois::ApplicationController
  def views_path
    'app/views/domains'
  end

  before do
    authenticate
  end

  get '/' do
    @domains = load_all
    render 'index'
  end

  get '/new' do
    @domain = build_domain
    render_new
  end

  post '/' do
    if build_domain_and_save
      redirect_to_list
    else
      render_new
    end
  end

  get '/:id' do
    @domain = load_domain
    render 'show'
  end

  delete '/:id' do
    load_domain.delete
    redirect_to_list
  end

  get '/:id/refresh' do
    load_domain.update_whois
    redirect_to_list
  end

  def load_all
    Domain.where(user_id: current_user.id).order(:expires_on)
  end

  def build_domain_and_save
    @domain = build_domain(name: request.params['domain'])
    @domain.save(raise_on_failure: false)
  end

  def redirect_to_list
    response.redirect '/domains'
  end

  def render_new
    render 'new'
  end

  def load_domain
    Domain.find(id: request.params[:id], user_id: current_user.id)
  end

  def build_domain(attributes = {})
    Domain.new(attributes.merge(user: current_user))
  end
end
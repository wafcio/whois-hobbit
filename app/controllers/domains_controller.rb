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
    UserDomain.where(domain_id: request.params[:id], user_id: current_user.id).delete
    redirect_to_list
  end

  get '/:id/refresh' do
    load_domain.update_whois
    redirect_to_list
  end

  def load_all
    current_user.domains.sort { |x,y| y.expires_on <=> x.expires_on }
  end

  def build_domain_and_save
    @domain = find_domain(request.params['domain']) || build_domain(name: request.params['domain']).save
    UserDomain.create(user_id: current_user.id, domain_id: @domain.id)
  end

  def redirect_to_list
    response.redirect '/domains'
  end

  def render_new
    render 'new'
  end

  def load_domain
    current_user.domains.select{ |domain| domain.id == request.params[:id].to_i }.first
  end

  def find_domain(name)
    Domain.where(name: name).first
  end

  def build_domain(attributes = {})
    Domain.new(attributes)
  end
end
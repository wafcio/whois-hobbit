require 'domain_name_validator'

class Domain < Sequel::Model
  plugin :validation_helpers

  one_to_many :user_domains
  many_to_many :domains, join_table: :user_domains
  one_to_many :contacts, class: :DomainContact
  one_to_many :nameservers, class: :DomainNameserver
  one_to_one :registrar, class: :DomainRegistrar

  def validate
    super

    validates_presence [:name]
    validates_unique :name
    
    validate_domain_name
  end

  def after_create
    super
    update_whois
  end

  def delete
    delete_contacts
    delete_nameservers
    delete_registrars

    super
  end

  def update_whois
    set(whois_attributes)
    save

    update_contacts
    update_nameservers
    update_registrar

    self
  end

  def whois
    @whois ||= {}
    @whois[name] ||= Whois.whois(name)
  end

  private

  def validate_domain_name
    if name && !DomainNameValidator.new.validate(name)
      errors.add(:name, 'is invalid')
    end
  end

  def whois_attributes
    @whois_attributes ||= {}
    @whois_attributes[name] ||= {
      server: whois.server.host,
      status: normalize_statuses(whois.status),
      is_available: whois.available?,
      is_registered: whois.registered?,
      content: whois.content,
      created_on: whois.created_on,
      updated_on: whois.updated_on,
      expires_on: whois.expires_on
    }
  end

  def normalize_statuses(statuses)
    statuses.is_a?(Array) ? statuses.join(', ') : statuses
  end

  def delete_contacts
    DomainContact.where(domain_id: id).delete
  end

  def delete_nameservers
    DomainNameserver.where(domain_id: id).delete
  end

  def delete_registrars
    DomainRegistrar.where(domain_id: id).delete
  end

  def resource_data(data)
    data = data.to_h.merge(domain_id: id)
    data[:external_id] = data.delete(:id)
    data
  end

  def nameserver_data(nameserver)
    nameserver.to_h.merge(domain_id: id)
  end

  def update_contacts
    delete_contacts

    whois.contacts.each do |contact|
      DomainContact.create(resource_data(contact))
    end
  end

  def update_nameservers
    delete_nameservers

    whois.nameservers.each do |nameserver|
      DomainNameserver.create(nameserver_data(nameserver))
    end
  end

  def update_registrar
    delete_registrars

    DomainRegistrar.create(resource_data(whois.registrar))
  end
end
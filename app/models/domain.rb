class Domain < Sequel::Model
  plugin :validation_helpers

  many_to_one :user
  one_to_many :contacts, class: :DomainContact
  one_to_many :nameservers, class: :DomainNameserver
  one_to_one :registrar, class: :DomainRegistrar

  def validate
    super

    validates_presence [:user, :name]
  end

  def after_create
    super
    update_whois
  end

  def delete
    DomainContact.where(domain_id: id).delete
    DomainNameserver.where(domain_id: id).delete
    DomainRegistrar.where(domain_id: id).delete

    super
  end

  def update_whois
    self.set(server: whois.server.host, status: whois.status, is_available: whois.available?,
      is_registered: whois.registered?, content: whois.content, created_on: whois.created_on,
      updated_on: whois.updated_on, expires_on: whois.expires_on)
    save

    DomainContact.where(domain_id: id).delete
    DomainNameserver.where(domain_id: id).delete
    DomainRegistrar.where(domain_id: id).delete

    whois.contacts.each do |contact|
      contact_data = contact.to_h.merge(domain_id: id)
      contact_data[:external_id] = contact_data.delete(:id)
      DomainContact.create(contact_data)
    end

    whois.nameservers.each do |nameserver|
      DomainNameserver.create(nameserver.to_h.merge(domain_id: id))
    end

    registrar_data = whois.registrar.to_h.merge(domain_id: id)
    registrar_data[:external_id] = registrar_data.delete(:id)
    DomainRegistrar.create(registrar_data)

    self
  end

  def whois
    @whois ||= Whois.whois(name)
  end
end
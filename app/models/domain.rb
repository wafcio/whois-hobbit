class Domain < Sequel::Model
  plugin :validation_helpers

  many_to_one :user
  one_to_many :contacts, class: :DomainContact
  one_to_many :nameservers, class: :DomainNameserver
  one_to_one :registrar, class: :DomainRegistrar

  def validate
    super

    validates_presence [:user, :name, :status]
  end
end
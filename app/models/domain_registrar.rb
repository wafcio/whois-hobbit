class DomainRegistrar < Sequel::Model
  many_to_one :domain
end
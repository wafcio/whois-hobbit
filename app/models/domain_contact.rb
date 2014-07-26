class DomainContact < Sequel::Model
  many_to_one :domain

  def created_at
    created_on
  end

  def updated_at
    updated_on
  end
end
class UserDomain < Sequel::Model
  many_to_one :user
  many_to_one :domain
end
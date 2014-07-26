class User < Sequel::Model
  one_to_many :domains
end

User.plugin :timestamps
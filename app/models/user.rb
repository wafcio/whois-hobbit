class User < Sequel::Model
  plugin :timestamps
  plugin :validation_helpers

  one_to_many :user_domains
  many_to_many :domains, join_table: :user_domains

  attr_accessor :password, :password_confirmation

  def validate
    super
    validates_unique :email
    validates_length_range 5..50, :email
    validates_format /\A[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}\z/i, :email, message: 'is invalid'

    validate_password if new?
  end

  def authenticate(password)
    password_digest == Digest::SHA1.hexdigest(password)
  end

  private

  def validate_password
    if password && !password.empty? && password_confirmation && !password_confirmation.empty? && password == password_confirmation
      self.password_digest = Digest::SHA1.hexdigest(password)
    else
      errors.add(:password, Sequel.lit("passwords doesn't match"))
    end
  end
end
class OmniauthUser
  attr_reader :auth

  def initialize(auth)
    @auth = auth
  end

  def uid_field
    "#{auth['provider']}_uid".to_sym
  end

  def user
    @user ||= find_or_create
  end

  private

  def find_or_create
    user = user_by_uid || user_by_email || build_user
    update_settings(user)
    user
  end

  def user_by_uid
    User.where(uid_field => auth['uid']).first
  end

  def user_by_email
    User.where(email: auth['info']['email']).first
  end

  def build_user
    User.new(
      email: auth['info']['email'],
      password: random_password,
      password_confirmation: random_password
    )
  end

  def update_settings(user)
    user.set(uid_field => auth['uid'])
    user.save
  end

  def random_password
    @random_password ||= SecureRandom.hex(64)
  end
end
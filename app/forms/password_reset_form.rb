class PasswordResetForm
  include ActiveModel::Model

  attr_accessor :password, :password_confirmation, :token

  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
  validate :token_valid?

  def user
    @user ||= User.find_by(reset_password_token: token)
  end

  def save
    return false unless valid?

    user.update(password: password)
  end

  private

  def token_valid?
    errors.add(:token, 'is invalid') if user.nil?
  end
end

class PasswordResetForm
  include ActiveModel::Model

  attr_accessor :password, :password_confirmation, :token

  validates :password, presence: true
  validates :password_confirmation, presence: true
  validate :passwords_match?
  validate :token_valid?

  def user
    @user ||= User.find_by(reset_password_token: token)
  end

  private

  def passwords_match?
    errors.add(:password_confirmation, "doesn't match") if password != password_confirmation
  end

  def token_valid?
    if user.blank? || user.reset_password_sent_at < 24.hours.ago
      errors.add(:token, 'is invalid or has expired')
    end
  end
end

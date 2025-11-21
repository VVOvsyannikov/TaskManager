module Users
  class PasswordResetService
    def initialize(user:)
      @user = user
    end

    def send_instructions!
      token = generate_token!
      UserMailer.with(user: @user, token: token).password_reset.deliver_now
    end

    def generate_token!
      token = SecureRandom.urlsafe_base64
      @user.update!(
        reset_password_token: token,
        reset_password_sent_at: Time.current,
      )
      token
    end

    def token_valid?
      @user&.reset_password_sent_at && @user.reset_password_sent_at > 24.hours.ago
    end

    def clear_token!
      @user.update!(
        reset_password_token: nil,
        reset_password_sent_at: nil,
      )
    end
  end
end

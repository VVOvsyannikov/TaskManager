module Users
  class PasswordResetRequest < ApplicationService
    def initialize(email:)
      @user = User.find_by(email: email)
    end

    def call
      return false unless @user

      generate_token!
      send_email
      true
    end

    private

    def generate_token!
      @token = SecureRandom.urlsafe_base64

      @user.update!(
        reset_password_token: @token,
        reset_password_sent_at: Time.current,
      )
    end

    def send_email
      UserMailer.with(user: @user, token: @token).password_reset.deliver_now
    end
  end
end

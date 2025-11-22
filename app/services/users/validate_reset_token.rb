module Users
  class ValidateResetToken < ApplicationService
    def initialize(token:)
      @token = token
    end

    def call
      user_present_and_recent?
    end

    private

    def user
      @user ||= User.find_by(reset_password_token: @token)
    end

    def user_present_and_recent?
      !!(user.present? && user.reset_password_sent_at && user.reset_password_sent_at > 24.hours.ago)
    end
  end
end

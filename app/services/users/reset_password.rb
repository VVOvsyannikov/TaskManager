module Users
  class ResetPassword < ApplicationService
    def initialize(password:, password_confirmation:, token:)
      @password = password
      @password_confirmation = password_confirmation
      @token = token
    end

    def call
      return false unless user
      return false unless password_valid?

      update_password_and_clear_token!
    end

    private

    def update_password_and_clear_token!
      user.update!(
        password: @password,
        reset_password_token: nil,
        reset_password_sent_at: nil,
      )
    end

    def user
      @user ||= User.find_by(reset_password_token: @token)
    end

    def password_valid?
      @password.present? && @password == @password_confirmation
    end
  end
end

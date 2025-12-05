module Users
  class ResetPassword < ApplicationService
    def initialize(user:, password:)
      @user = user
      @password = password
    end

    def call
      return nil unless @user

      @user.update!(
        password: @password,
        reset_password_token: nil,
        reset_password_sent_at: nil,
      )
    end
  end
end

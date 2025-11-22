require 'test_helper'

class Users::ValidateResetTokenTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @token = SecureRandom.urlsafe_base64
    @user.update!(
      reset_password_token: @token,
      reset_password_sent_at: Time.current,
    )
  end

  test 'returns true for valid token' do
    service = Users::ValidateResetToken.new(token: @token)
    assert_equal true, service.call
  end

  test 'returns false for invalid token' do
    service = Users::ValidateResetToken.new(token: 'invalid')
    assert_equal false, service.call
  end

  test 'returns false if token is expired' do
    @user.update!(reset_password_sent_at: 25.hours.ago)
    service = Users::ValidateResetToken.new(token: @token)
    assert_equal false, service.call
  end

  test 'returns false if user has no reset_password_sent_at' do
    @user.update!(reset_password_sent_at: nil)
    service = Users::ValidateResetToken.new(token: @token)
    assert_equal false, service.call
  end
end

require 'test_helper'
require 'minitest/mock'

class Users::PasswordResetRequestTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
  end

  test 'does nothing if email is nil' do
    result = Users::PasswordResetRequest.call(email: nil)
    assert_equal false, result
  end

  test 'does nothing if email does not exist' do
    result = Users::PasswordResetRequest.call(email: 'notfound@example.com')
    assert_equal false, result
  end

  test 'generates token and sends email for valid user' do
    token = nil

    UserMailer.stub(:with, ->(args) {
      token = args[:token]
      OpenStruct.new(password_reset: OpenStruct.new(deliver_now: true))
    }) do
      result = Users::PasswordResetRequest.call(email: @user.email)
      assert_equal true, result
    end

    @user.reload
    assert_equal token, @user.reset_password_token
    assert_in_delta Time.current, @user.reset_password_sent_at, 1.second
  end
end

require 'test_helper'

class Users::ResetPasswordTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @token = SecureRandom.urlsafe_base64
    @user.update!(
      reset_password_token: @token,
      reset_password_sent_at: Time.current,
    )
  end

  test 'returns false if token is invalid' do
    service = Users::ResetPassword.new(
      password: 'newpass',
      password_confirmation: 'newpass',
      token: 'invalid',
    )

    result = service.call
    assert_equal false, result
  end

  test 'returns false if passwords do not match' do
    service = Users::ResetPassword.new(
      password: 'pass1',
      password_confirmation: 'pass2',
      token: @token,
    )

    result = service.call
    assert_equal false, result
  end

  test 'successfully updates password and clears token' do
    service = Users::ResetPassword.new(
      password: 'newpassword',
      password_confirmation: 'newpassword',
      token: @token,
    )

    result = service.call
    assert_equal true, result

    @user.reload
    assert @user.authenticate('newpassword')
    assert_nil @user.reset_password_token
    assert_nil @user.reset_password_sent_at
  end

  test 'reset link cannot be reused' do
    service = Users::ResetPassword.new(
      password: 'newpassword',
      password_confirmation: 'newpassword',
      token: @token,
    )

    result1 = service.call
    assert_equal true, result1

    # Повторный вызов
    service2 = Users::ResetPassword.new(
      password: 'anotherpass',
      password_confirmation: 'anotherpass',
      token: @token,
    )
    result2 = service2.call
    assert_equal false, result2
  end
end

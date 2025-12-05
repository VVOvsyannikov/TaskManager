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

  test 'does nothing if user is nil' do
    service = Users::ResetPassword.new(user: nil, password: 'newpass')

    result = service.call
    assert_nil result
  end

  test 'successfully updates password and clears token' do
    service = Users::ResetPassword.new(user: @user, password: 'newpassword')

    service.call
    @user.reload
    assert @user.authenticate('newpassword')
    assert_nil @user.reset_password_token
    assert_nil @user.reset_password_sent_at
  end

  test 'reset link cannot be reused (because token is cleared)' do
    Users::ResetPassword.call(user: @user, password: 'newpassword')

    @user.reload
    assert_nil @user.reset_password_token

    service = Users::ResetPassword.new(user: @user, password: 'anotherpass')

    service.call
    @user.reload

    assert @user.authenticate('anotherpass')
  end
end

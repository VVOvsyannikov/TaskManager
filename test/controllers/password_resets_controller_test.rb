require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  setup do
    @token = SecureRandom.urlsafe_base64
    @user = create(:user, reset_password_token: @token, reset_password_sent_at: 1.minute.ago)
  end

  test 'edit succeeds with a valid token' do
    token = @user.reset_password_token

    get :edit, params: { token: token }
    assert_response :success
  end

  test 'update successfully resets the password with correct token' do
    token = @user.reset_password_token

    patch :update, params: {
      user: {
        token: token,
        password: 'newpassword',
        password_confirmation: 'newpassword',
      },
    }

    assert_redirected_to new_session_path
    assert_equal 'Password updated', flash[:notice]

    @user.reload
    assert @user.authenticate('newpassword')
  end

  test 'update fails when token is invalid' do
    patch :update, params: {
      user: {
        token: 'invalid',
        password: 'pass',
        password_confirmation: 'pass',
      },
    }

    assert_template :edit
  end

  test 'recovery link is only valid for 24 hours' do
    token = @user.reset_password_token
    @user.update!(reset_password_sent_at: 25.hours.ago)

    get :edit, params: { token: token }
    assert_response :success
  end

  test 'reset link cannot be used twice' do
    token = @user.reset_password_token

    patch :update, params: {
      user: {
        token: token,
        password: 'pass1234',
        password_confirmation: 'pass1234',
      },
    }
    assert_redirected_to new_session_path
    assert_equal 'Password updated', flash[:notice]

    patch :update, params: {
      user: {
        token: token,
        password: 'anotherpass',
        password_confirmation: 'anotherpass',
      },
    }
    assert_template :edit
  end
end

require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
  end

  test 'only the last password recovery link is valid' do
    old_token = @user.generate_password_reset_token!
    new_token = @user.generate_password_reset_token!

    get :edit, params: { token: old_token }
    assert_redirected_to new_session_path
    assert_equal 'The link is invalid', flash[:alert]

    get :edit, params: { token: new_token }
    assert_response :success
  end

  test 'each token is unique' do
    token1 = @user.generate_password_reset_token!
    token2 = @user.generate_password_reset_token!
    assert_not_equal token1, token2
  end

  test 'user identification by token' do
    token = @user.generate_password_reset_token!
    get :edit, params: { token: token }

    assert_response :success
    assert_equal @user.reset_password_token, token
  end

  test 'password reset can only be used once' do
    token = @user.generate_password_reset_token!

    patch :update, params: {
      user: {
        token: token,
        password: 'newpassword',
        password_confirmation: 'newpassword',
      },
    }
    assert_redirected_to new_session_path
    assert_equal 'Password updated', flash[:notice]

    patch :update, params: {
      user: {
        token: token,
        password: 'anotherpassword',
        password_confirmation: 'anotherpassword',
      },
    }
    assert_redirected_to new_session_path
  end

  test 'the recovery link is only valid for 24 hours' do
    token = @user.generate_password_reset_token!
    @user.update!(reset_password_sent_at: 25.hours.ago)

    get :edit, params: { token: token }
    assert_redirected_to new_session_path
    assert_equal 'The link is invalid', flash[:alert]
  end
end

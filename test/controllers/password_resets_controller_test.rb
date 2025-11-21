require 'test_helper'

class PasswordResetsControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    @service = Users::PasswordResetService.new(user: @user)
  end

  test 'only the last password recovery link is valid' do
    old_token = @service.generate_token!
    new_token = @service.generate_token!

    get :edit, params: { token: old_token }
    assert_redirected_to new_session_path
    assert_equal 'The link is invalid', flash[:alert]

    get :edit, params: { token: new_token }
    assert_response :success
  end

  test 'each token is unique' do
    token1 = @service.generate_token!
    token2 = @service.generate_token!
    assert_not_equal token1, token2
  end

  test 'user identification by token' do
    token = @service.generate_token!
    get :edit, params: { token: token }

    assert_response :success
    assert_equal @user.reset_password_token, token
  end

  test 'password reset can only be used once' do
    token = @service.generate_token!

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
    token = @service.generate_token!
    @user.update!(reset_password_sent_at: 25.hours.ago)

    get :edit, params: { token: token }
    assert_redirected_to new_session_path
    assert_equal 'The link is invalid', flash[:alert]
  end
end

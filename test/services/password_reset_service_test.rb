require 'test_helper'

class Users::PasswordResetServiceTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
    @service = Users::PasswordResetService.new(user: @user)
  end

  test '#send_instructions! generates token and sends mail' do
    assert_emails 1 do
      @service.send_instructions!
    end

    @user.reload
    assert @user.reset_password_token.present?
    assert @user.reset_password_sent_at.present?
  end

  test '#generate_token! sets token and timestamp' do
    token = @service.generate_token!

    @user.reload
    assert_equal token, @user.reset_password_token
    assert @user.reset_password_sent_at.present?
  end

  test '#token_valid? returns true when token was sent less than 24h ago' do
    @user.update!(
      reset_password_token: 'abc123',
      reset_password_sent_at: 2.hours.ago,
    )

    assert @service.token_valid?
  end

  test '#token_valid? returns false when token is older than 24h' do
    @user.update!(
      reset_password_token: 'abc123',
      reset_password_sent_at: 25.hours.ago,
    )

    refute @service.token_valid?
  end

  test '#token_valid? returns false when reset_password_sent_at is nil' do
    @user.update!(reset_password_token: 'abc123', reset_password_sent_at: nil)

    refute @service.token_valid?
  end

  test '#clear_token! clears token and timestamp' do
    @user.update!(
      reset_password_token: 'abc123',
      reset_password_sent_at: Time.current,
    )

    @service.clear_token!
    @user.reload

    assert_nil @user.reset_password_token
    assert_nil @user.reset_password_sent_at
  end
end

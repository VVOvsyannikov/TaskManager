class SendPasswordResetNotificationJob < ApplicationJob
  sidekiq_options queue: :mailers
  sidekiq_throttle_as :mailer

  def perform(user_id, token)
    user = User.find_by(id: user_id)
    return if user.blank?

    UserMailer.with(user: user, token: token).password_reset.deliver_now
  end
end

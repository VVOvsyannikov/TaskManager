class SendTaskDeleteNotificationJob < ApplicationJob
  sidekiq_options queue: :mailers
  sidekiq_throttle_as :mailer

  def perform(user_id, id)
    user = User.find_by(id: user_id)
    return if user.blank?

    UserMailer.with(user: user, id: id).task_deleted.deliver_now
  end
end

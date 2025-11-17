class User < ApplicationRecord
  has_secure_password

  has_many :my_tasks, class_name: 'Task', foreign_key: :author_id
  has_many :assigned_tasks, class_name: 'Task', foreign_key: :assignee_id

  validates :first_name, :last_name, presence: true
  validates :first_name, :last_name, length: { minimum: 2 }
  validates :email, format: { with: /@/ }
  validates :email, uniqueness: true

  validates :password, confirmation: true, on: :password_reset
  validates :password_confirmation, presence: true, on: :password_reset

  def generate_password_reset_token!
    token = SecureRandom.urlsafe_base64
    update!(
      reset_password_token: token,
      reset_password_sent_at: Time.current,
    )
    token
  end

  def password_reset_token_valid?
    reset_password_sent_at && reset_password_sent_at > 24.hours.ago
  end

  def clear_reset_password_token!
    update!(
      reset_password_token: nil,
      reset_password_sent_at: nil,
    )
  end
end

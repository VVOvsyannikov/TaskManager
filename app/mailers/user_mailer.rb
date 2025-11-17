class UserMailer < ApplicationMailer
  layout 'mailer'

  def task_created
    user = params[:user]
    @task = params[:task]

    mail(from: 'noreply@taskmanager.com', to: user.email, subject: 'New Task Created')
  end

  def task_updated
    user = params[:user]
    @task = params[:task]

    mail(from: 'noreply@taskmanager.com', to: user.email, subject: 'Task Updated')
  end

  def task_deleted
    user = params[:user]
    @id = params[:id]

    mail(from: 'noreply@taskmanager.com', to: user.email, subject: 'Task Deleted')
  end

  def password_reset
    user = params[:user]
    token = params[:token]
    @url = edit_password_reset_url(token: token)

    mail(from: 'noreply@taskmanager.com', to: user.email, subject: 'Password recovery')
  end
end

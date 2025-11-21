class UserMailerPreview < ActionMailer::Preview
  def task_created
    user = User.first
    task = Task.first
    params = { user: user, task: task }

    UserMailer.with(params).task_created
  end

  def task_updated
    user = User.first
    task = Task.first
    params = { user: user, task: task }

    UserMailer.with(params).task_updated
  end

  def task_deleted
    user = User.first
    id = Task.first.id
    params = { user: user, id: id }

    UserMailer.with(params).task_deleted
  end

  def password_reset
    user = User.first
    token = user.generate_password_reset_token!
    params = { user: user, token: token }

    UserMailer.with(params).password_reset
  end
end

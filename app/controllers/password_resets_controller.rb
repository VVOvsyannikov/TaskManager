class PasswordResetsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: user_params[:email])

    if user
      token = user.generate_password_reset_token!
      UserMailer.with(user: user, token: token).password_reset.deliver_later
    end

    redirect_to(new_session_path, notice: 'If such an email exists, password recovery instructions have been sent.')
  end

  def edit
    @user = User.find_by(reset_password_token: params[:token])

    redirect_to(new_session_path, alert: 'The link is invalid') unless @user&.password_reset_token_valid?
  end

  def update
    user = User.find_by(reset_password_token: user_params[:token])
    return redirect_to(new_session_path, alert: 'Invalid token') unless user&.password_reset_token_valid?

    user.password = user_params[:password]
    user.password_confirmation = user_params[:password_confirmation]

    if user.save(context: :password_reset)
      user.clear_reset_password_token!
      redirect_to(new_session_path, notice: 'Password updated')
    else
      render(:edit)
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :token, :email)
  end
end

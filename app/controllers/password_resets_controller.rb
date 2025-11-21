class PasswordResetsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: user_params[:email])

    if user
      service = password_reset_service(user)
      service.send_instructions!
    end

    redirect_to(new_session_path, notice: 'If such an email exists, password recovery instructions have been sent.')
  end

  def edit
    @user = User.find_by(reset_password_token: params[:token])
    service = password_reset_service(@user)

    unless @user && service.token_valid?
      redirect_to(new_session_path, alert: 'The link is invalid')
    end
  end

  def update
    user = User.find_by(reset_password_token: user_params[:token])
    service = password_reset_service(user)

    return redirect_to(new_session_path, alert: 'Invalid token') unless service.token_valid?

    user.password = user_params[:password]
    user.password_confirmation = user_params[:password_confirmation]

    if user.save(context: :password_reset)
      service.clear_token!
      redirect_to(new_session_path, notice: 'Password updated')
    else
      render(:edit)
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :token, :email)
  end

  def password_reset_service(user)
    Users::PasswordResetService.new(user: user)
  end
end

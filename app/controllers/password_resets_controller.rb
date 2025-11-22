class PasswordResetsController < ApplicationController
  def new; end

  def create
    Users::PasswordResetRequest.call(**user_params.to_h.symbolize_keys)
    redirect_to(new_session_path, notice: 'If such an email exists, password recovery instructions have been sent.')
  end

  def edit
    result = Users::ValidateResetToken.call(token: params[:token])
    redirect_to(new_session_path, alert: 'The link is invalid') unless result
  end

  def update
    result = Users::ResetPassword.call(**user_params.to_h.symbolize_keys)

    if result
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

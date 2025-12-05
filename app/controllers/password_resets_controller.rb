class PasswordResetsController < ApplicationController
  def new; end

  def create
    Users::PasswordResetRequest.call(**user_params.to_h.symbolize_keys)
    redirect_to(new_session_path, notice: 'If such an email exists, password recovery instructions have been sent.')
  end

  def edit
    @form = PasswordResetForm.new(token: params[:token])
  end

  def update
    @form = PasswordResetForm.new(user_params)

    if @form.valid?
      Users::ResetPassword.call(user: @form.user, password: @form.password)
      redirect_to(new_session_path, notice: 'Password updated')
    else
      render(:edit, status: :unprocessable_entity)
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :token, :email)
  end
end

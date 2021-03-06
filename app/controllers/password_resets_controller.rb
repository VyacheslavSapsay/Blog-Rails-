# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  before_action :find_author, only: %i[edit update]

  def new; end

  def create
    redirect_to root_path(current_author) if current_author
    author = Author.find_by_email(params[:email])
    author&.send_password_reset
    flash[:success] = 'Email sent with password reset instructions.'
    redirect_to root_path
  end

  def edit; end

  def update
    redirect_to root_path(current_author) if current_author
    if @author.password_reset_sent_at < 1.hour.ago
      redirect_to new_password_reset_path, alert: 'Password reset has expired.'
    elsif @author.update_attributes(params.require(:author).permit(:password, :password_confirmation))
      redirect_to root_path
      flash[:success] = 'Password has been reset!'
    else
      render :edit
    end
  end

  private

  def find_author
    @author = Author.find_by_confirm_token!(params[:id])
  end
end

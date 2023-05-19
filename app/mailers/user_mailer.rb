class UserMailer < ApplicationMailer
  default from: "amanvhora745@gmail.com"
  layout "custom", only: :changed_email

  def welcome_email
    @user = params[:user]
    @url = "http://localhost:3000/users"
    mail(to: @user.email, subject: "Welcome to action mailer") do |format|
      format.text { render 'user_mailer/welcome_email' }
      format.html { render 'user_mailer/welcome_email' }
    end
  end

  def changed_email
    @user = params[:user]
    @old_email = params[:old_email]
    @url = "http://localhost:3000/users"
    mail(to: @user.email, subject: "Changing email address") do |format|
      format.text { render 'user_mailer/changed_email' }
      format.html { render 'user_mailer/changed_email' }
    end
  end
end

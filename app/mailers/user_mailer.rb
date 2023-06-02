class UserMailer < ApplicationMailer
  default from: ENV["GMAIL_USERNAME"]
  layout "custom", only: :changed_email

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: "Welcome to action mailer") do |format|
      format.text { render 'user_mailer/welcome_email' }
      format.html { render 'user_mailer/welcome_email' }
    end
  end

  def changed_email
    @user = params[:user]
    @old_email = params[:old_email]
    mail(to: @user.email, subject: "Changing email address") do |format|
      format.text { render 'user_mailer/changed_email' }
      format.html { render 'user_mailer/changed_email' }
    end
  end

  def send_events_list(users_emails)
    @events = Event.all
    mail(to: users_emails, subject: "Available events list") do |format|
      format.text { render 'user_mailer/send_events_list' }
      format.html { render 'user_mailer/send_events_list' }
    end
  end

  def send_reminder_email(users_emails, event)
    @event = event
    mail(to: users_emails, subject: "Reminder email") do |format|
      format.text { render 'user_mailer/send_reminder_email' }
      format.html { render 'user_mailer/send_reminder_email' }
    end
  end
end

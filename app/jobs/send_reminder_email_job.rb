class SendReminderEmailJob
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    today_events = Event.where(event_date: Date.today.beginning_of_day..Date.today.end_of_day)
    today_events.each do |event|
      reminder_time = event.event_date - 5.hours
      users_emails = event.users.pluck(:email)
      UserMailer.send_reminder_email(users_emails, event).deliver_later(wait_until: reminder_time)
    end
  end
end

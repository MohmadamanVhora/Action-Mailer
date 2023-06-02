class SendEventsListJob
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    users_emails = User.pluck(:email)
    UserMailer.send_events_list(users_emails).deliver_later
  end
end

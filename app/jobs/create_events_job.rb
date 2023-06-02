class CreateEventsJob
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform
    Event.create(event_name: "Event #{rand(100)}", event_date: DateTime.now + (rand * 7))
  end
end

FactoryBot.define do
  factory :event do
    event_name { Faker::Lorem.sentence(word_count: 2) }
    event_date { Faker::Time.between(from: DateTime.now, to: DateTime.now + 7) }

    after(:create) do |event|
      event.users << FactoryBot.create_list(:user, 10)
    end
  end
end

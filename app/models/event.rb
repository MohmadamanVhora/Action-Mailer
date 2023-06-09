class Event < ApplicationRecord
  has_and_belongs_to_many :users
  validates :event_name, :event_date, presence: true
end

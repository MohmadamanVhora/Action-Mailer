require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'association' do
    it { should have_and_belong_to_many :users }
  end

  describe 'validations' do
    it { should validate_presence_of :event_name }
    it { should validate_presence_of :event_date }
  end
end

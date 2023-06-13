require 'rails_helper'

RSpec.describe User, type: :model do
  before { @user = create(:user) }

  describe 'validations' do
    it 'valid with valid attributes' do
      expect(@user).to be_valid
    end

    it 'invalid without name' do
      @user.name = ''
      expect(@user).not_to be_valid
    end

    it 'invalid without email' do
      @user.email = ''
      expect(@user).not_to be_valid
    end

    it 'invalid with already existed email' do
      invalid_user = create(:user)
      invalid_user.email = @user.email
      expect(invalid_user).not_to be_valid
    end

    it 'invalid without proper email format' do
      @user.email = 'testing@example'
      expect(@user).not_to be_valid

      @user.email = 'testing.example'
      expect(@user).not_to be_valid
    end

    it 'invalid without password' do
      @user.password = nil
      expect(@user).not_to be_valid
    end

    it 'invalid with less than 6 characters password' do
      @user.password = 'a' * 5
      expect(@user).not_to be_valid
    end

    it 'invalid without password confirmation' do
      @user.password_confirmation = 'mismatched'
      expect(@user).not_to be_valid
    end

    it 'invalid without profile picture' do
      @user.profile = ''
      expect(@user).not_to be_valid
    end
  end

  describe "associations" do
    it { should have_one :employee }
    it { should have_and_belong_to_many :events }
  end
end

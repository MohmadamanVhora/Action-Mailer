require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  let(:event) { create(:event) }

  let(:valid_user) do
    {
      name: Faker::Name.first_name,
      email: Faker::Internet.unique.email,
      password: Faker::Internet.password(min_length: 6),
      profile: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'test_image.png'), 'image/png')
    }
  end

  let(:invalid_user) do
    {
      username: Faker::Name.first_name,
      email: Faker::Internet.unique.email,
      pass: Faker::Internet.password(min_length: 6),
      profile: Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'test_image.png'), 'image/png')
    }
  end

  describe 'GET /users' do
    it 'should get index' do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /show' do
    it 'should get show' do
      get user_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /new' do
    it 'should get new' do
      get new_user_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /edit' do
    it 'should get edit' do
      get edit_user_path(user)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /create' do
    it 'with valid parameters should create user' do
      expect do
        post users_path, params: { user: valid_user }
      end.to change { User.count }.by(1)
      expect(response).to redirect_to(user_path(User.last))
    end

    it 'with invalid parameters should not create user' do
      expect do
        post users_path, params: { user: invalid_user }
      end.to change { User.count }.by(0)
      expect(response).to have_http_status(422)
    end
  end

  describe 'PATCH /update' do
    it 'with valid parameters should update user' do
      patch user_path(user), params: { user: { name: 'Aman' } }
      expect(User.last.name).to eq('Aman')
      expect(response).to redirect_to(user_path(user))
    end

    it 'with invalid parameters should not update user' do
      patch user_path(user), params: { user: { username: 'Aman' } }
      expect(User.last.name).not_to eq('Aman')
    end
  end

  describe 'DELETE /destroy' do
    it 'should destroy user' do
      user = User.create valid_user
      expect do
        delete user_path(user)
      end.to change { User.count }.by(-1)
      expect(response).to redirect_to(users_path)
    end
  end

  describe 'GET /enroll_event' do
    it 'should user enroll event' do
      expect do
        get enroll_event_user_path(user, event)
      end.to change { event.users.count }.by(1)
      expect(response).to redirect_to(user_path(user))
    end
  end

  describe 'GET /discard_enrolled_event' do
    it 'should user discard enrolled event' do
      get enroll_event_user_path(user, event)
      expect do
        get discard_enrolled_event_user_path(user, event)
      end.to change { event.users.count }.by(-1)
      expect(response).to redirect_to(user_path(user))
    end
  end
end

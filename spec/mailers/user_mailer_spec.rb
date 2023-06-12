require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }

  describe 'welcome_email' do
    let(:welcome_mail) { UserMailer.with(user:).welcome_email }

    it 'send welcome_email' do
      expect { welcome_mail }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'render subject' do
      expect(welcome_mail.subject).to eq('Welcome to action mailer')
    end

    it 'render sender email' do
      expect(welcome_mail.from).to eq([ENV['GMAIL_USERNAME']])
    end

    it 'render reciever email' do
      expect(welcome_mail.to).to eq([user.email])
    end

    it 'render email in body' do
      expect(welcome_mail.body.encoded).to match("Welcome to action mailer practical, #{user.email}")
    end

    it 'render name in body' do
      expect(welcome_mail.body.encoded).to match(user.name)
    end

    it 'render link in body' do
      expect(welcome_mail.body.encoded).to match(root_url)
    end
  end

  describe 'changed_email' do
    let(:changed_mail) { UserMailer.with(user:).changed_email }

    it 'send changed_email' do
      expect { changed_mail }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it 'render subject' do
      expect(changed_mail.subject).to eq('Changing email address')
    end

    it 'render sender email' do
      expect(changed_mail.from).to eq([ENV['GMAIL_USERNAME']])
    end

    it 'render reciever email' do
      expect(changed_mail.to).to eq([user.email])
    end

    it 'render body' do
      expect(changed_mail.body.encoded).to match('You have successfully updated your email address')
    end
  end

  describe 'send_events_list' do
    let(:users) { create_list(:user, 10) }
    let(:send_events_list_mail) { UserMailer.send_events_list(users.pluck(:email)) }

    it 'send_events_list_email' do
      initial_count = ActionMailer::Base.deliveries.count
      send_events_list_mail
      final_count = ActionMailer::Base.deliveries.count

      expect(final_count - initial_count).to eq(users.count)
    end

    it 'render subject' do
      expect(send_events_list_mail.subject).to eq('Available events list')
    end

    it 'render sender email' do
      expect(send_events_list_mail.from).to eq([ENV['GMAIL_USERNAME']])
    end

    it 'render reciever emails' do
      expect(send_events_list_mail.to).to eq(users.pluck(:email))
    end

    it 'render body' do
      expect(send_events_list_mail.body.encoded).to match('Events Schedule:-')
    end
  end

  describe 'send_reminder_email' do
    let(:event) { create(:event) }
    let(:send_reminder_mail) { UserMailer.send_reminder_email(event.users.pluck(:email), event) }

    it 'send_events_list_email' do
      initial_count = ActionMailer::Base.deliveries.count
      send_reminder_mail
      final_count = ActionMailer::Base.deliveries.count

      expect(final_count - initial_count).to eq(event.users.count)
    end

    it 'render subject' do
      expect(send_reminder_mail.subject).to eq('Reminder email')
    end

    it 'render sender email' do
      expect(send_reminder_mail.from).to eq([ENV['GMAIL_USERNAME']])
    end

    it 'render reciever emails' do
      expect(send_reminder_mail.to).to eq(event.users.pluck(:email))
    end

    it 'render body' do
      expect(send_reminder_mail.body.encoded).to match('You have Registered in an event')
    end
  end
end

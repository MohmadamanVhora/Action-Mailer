class User < ApplicationRecord
  has_secure_password
  mount_uploader :profile, ProfileUploader
  attr_reader :old_email
  after_create :send_welcome_email, :create_employee
  has_one :employee, dependent: :destroy
  has_and_belongs_to_many :events

  private
  def send_welcome_email
    SendEmailsJob.perform_now(self)
  end

  def create_employee 
    CreateEmployeeJob.set(wait: 2.minutes).perform_later(self.id)
  end
end

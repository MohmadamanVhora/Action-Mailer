class User < ApplicationRecord
  has_secure_password
  mount_uploader :profile, ProfileUploader
  attr_reader :old_email

  after_create :send_welcome_email, :create_employee
  has_one :employee, dependent: :destroy
  has_and_belongs_to_many :events
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, if: :password_digest_changed?
  validates :profile, presence: true

  private

  def send_welcome_email
    SendEmailsJob.perform_now(self)
  end

  def create_employee
    CreateEmployeeJob.set(wait: 2.minutes).perform_later(id)
  end
end

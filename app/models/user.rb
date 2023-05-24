class User < ApplicationRecord
  has_secure_password
  mount_uploader :profile, ProfileUploader
  attr_reader :old_email
end

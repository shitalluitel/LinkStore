class UserInformation < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  validates :user_id, uniqueness: true
end

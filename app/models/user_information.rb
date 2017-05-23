class UserInformation < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  validates :user_id, uniqueness: true
end

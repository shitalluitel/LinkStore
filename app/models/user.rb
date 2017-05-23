class User < ApplicationRecord
  include ActiveModel::Validations
  attr_accessor :email_format

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, :presence => true, :email_format => true
  has_many :categories
  has_many :topics
  has_many :links
  has_one :user_information
end

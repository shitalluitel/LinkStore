class Category < ApplicationRecord
  has_many :topics, :dependent => :destroy
  has_many :links, :dependent => :destroy
  belongs_to :user

  validates :name, presence: true
  validates_uniqueness_of :name, :scope => [:user_id]
  validates :description, :length => {:maximum => 918}

  def self.search(search, id)
    if search
      where("user_id = ? and lower(name) like ? ",id, "%#{search.downcase}%").order("name ASC")
    else
      where("user_id = ?", id).order("name ASC")
    end
  end

  def self.fav_search(search, id)
    if search
      where("user_id = ? and favorite = ? and lower(name) like ? ",id, true, "%#{search.downcase}%").order("name ASC")
    else
      where("user_id = ? and favorite = ?", id, true).order("name ASC")
    end
  end
end

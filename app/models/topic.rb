class Topic < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :links, :dependent => :destroy
  before_save :smart_capitalize

  validates :name, :presence => true
  validates_uniqueness_of :name, :scope => [:user_id]
  validates :description, :length => {:maximum => 918}

  def self.search(catagory,search, id)
    if search
      where("category_id = ? and user_id = ? and lower(name) like ? ", catagory, id, "%#{search.downcase}%").order("name ASC")
    else
      where("category_id = ? and user_id = ? ", catagory, id).order("name ASC")
    end
  end

  def self.fav_search(catagory, search, id)
    if search
      where("category_id = ? and user_id = ? and lower(name) like ? and favorite = ? ", catagory, id, "%#{search.downcase}%", true).order("name ASC")
    else
      where("category_id = ? and user_id = ? and favorite = ? ", catagory, id, true).order("name ASC")
    end
  end

  def self.fav_search_all(search, id)
    if search
      where("user_id = ? and lower(name) like ? and favorite = ? ", id, "%#{search.downcase}%", true).order("name ASC")
    else
      where("user_id = ? and favorite = ? ",id, true).order("name ASC")
    end
  end

  protected

  def smart_capitalize
    self.name = self.name.titleize
    self.description = self.description.capitalize
  end

end

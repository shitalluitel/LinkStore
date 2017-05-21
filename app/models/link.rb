class Link < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  belongs_to :category
  validates :link, presence: true
  before_save :smart_add_url_protocol

  validates :name, :presence => true
  validates_uniqueness_of :name, :scope => [:user_id]
  validates :description, :length => {:maximum => 918}

  def self.supply_links(topic,id,search)
    if search
      where("topic_id = ? and user_id =? and lower(name) like ?", topic, id,  "%#{search.downcase}%").select(:name, :description,:link, :favorite, :id).order("name ASC")
    else
      where("topic_id = ? and user_id =? ", topic, id).select(:name, :description,:link, :favorite, :id).order("name ASC")
    end
  end

  def self.search(topic,id,search)
    if search
      where("topic_id = ? and user_id =? and lower(name) like ? and favorite = ?", topic, id,  "%#{search.downcase}%", true).select(:name, :description,:link, :favorite, :id).order("name ASC")
    else
      where("topic_id = ? and user_id =?  and favorite = ? ", topic, id, true).select(:name, :description,:link, :favorite, :id).order("name ASC")
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

  def smart_add_url_protocol
    unless self.link[/\Ahttp:\/\//] || self.link[/\Ahttps:\/\//]
      self.link = "https://#{self.link}"
    end
    self.name = self.name.titleize
    self.description = self.description.capitalize
  end
end

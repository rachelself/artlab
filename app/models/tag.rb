class Tag < ActiveRecord::Base

  has_many :artist_tags
  has_many :users, :through => :artist_tags

  validates_presence_of :name
  validates_uniqueness_of :name

end

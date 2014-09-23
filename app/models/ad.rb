class Ad < ActiveRecord::Base

  belongs_to :user
  has_many :ad_tags
  has_many :tags, :through => :ad_tags
  accepts_nested_attributes_for :ad_tags

  mount_uploader :project_photo, ProjectPhotoUploader

  validates_presence_of :title, :description, message: "can't be blank"
  validates_length_of :title, maximum: 50, message: "must be less than 50 characters", allow_blank: true
  validates_format_of :title, :description, with: /[a-zA-Z]/, message: "must include letters", allow_blank: true
  validates_length_of :description, maximum: 500, message: "500 is the maximum allowed", allow_blank: true

  def self.find_by(id)
    self.where(id: id)
  end
  
end

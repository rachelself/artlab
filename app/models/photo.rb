class Photo < ActiveRecord::Base

  belongs_to :gallery
  mount_uploader :image, GalleryPhotoUploader

  validates_presence_of :image, message: "must upload at least one photo"
  validates_presence_of :gallery_id, message: "must choose a gallery"
  validates_format_of :caption, with: /[a-zA-Z]/, message: "must include letters", allow_blank: true
  validates_length_of :caption, maximum: 50, message: "50 is the maximum allowed"
end

class ArtistTag < ActiveRecord::Base

  belongs_to :tag
  belongs_to :user

  validates_presence_of :user_id, message: "can't be blank"
  validates_presence_of :tag_id, message: "can't be blank"
end

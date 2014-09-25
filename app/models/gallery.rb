class Gallery < ActiveRecord::Base
  belongs_to :user
  has_many :photos

  validates_presence_of :title
  validates_length_of :title, maximum: 30, message: "30 is the maximum allowed", allow_blank: false
  validates_format_of :title, :description, with: /[a-zA-Z]/, message: "must include letters", allow_blank: true
  validates_length_of :description, maximum: 300, message: "300 is the maximum allowed", allow_blank: true
end

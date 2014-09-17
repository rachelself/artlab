class User < ActiveRecord::Base

  has_many :galleries
  has_many :ads
  mount_uploader :profile_image, ProfileImageUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_length_of :first_name, :last_name, maximum: 30, message: "must be less than 30 characters", allow_blank: true
  validates_format_of :first_name, :last_name, with: /[a-zA-Z]/, message: "must include letters", allow_blank: true
  validates_length_of :bio, maximum: 500, message: "500 is the maximum allowed", allow_blank: true
  validates_format_of :bio, with: /[a-zA-Z]/, message: "must include letters", allow_blank: true

end

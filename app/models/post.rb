class Post < ApplicationRecord
  mount_uploader :file, FileUploader
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :hashtags, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :hashtags
  has_many  :follows, through: :user
end

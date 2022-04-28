class Post < ApplicationRecord
  mount_uploader :file, S3Uploader
  mount_uploader :image, S3Uploader
  belongs_to :user
  has_many :hashtags, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :hashtags
  has_many  :follows, through: :user
end

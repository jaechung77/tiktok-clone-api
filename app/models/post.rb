class Post < ApplicationRecord
  mount_uploader :file, FileUploader
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :hashtags, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :hashtags
  has_many  :follows, through: :user

  before_destroy :destroy_assets

  def destroy_assets
      self.image.remove! if self.image
      self.save!
  end
end

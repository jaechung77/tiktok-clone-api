class Follow < ApplicationRecord
  has_many :posts, through: :user
  has_many :users
end


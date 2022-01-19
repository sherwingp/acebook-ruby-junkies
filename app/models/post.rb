class Post < ApplicationRecord
  has_one_attached :image, :dependent => :destroy, service: :local
  belongs_to :user
  has_many :likes, dependent: :destroy
end

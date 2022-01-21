class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_one_attached :image, :dependent => :destroy, service: :local
  validates :body, presence: true, length: { minimum: 1 }

  has_many :likes, as: :likeable, dependent: :destroy
end

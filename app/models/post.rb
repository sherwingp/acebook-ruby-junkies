class Post < ApplicationRecord
  has_many :comments, :dependent => :destroy
  has_one_attached :image, :dependent => :destroy, service: :local
  belongs_to :user

  validates :message, presence: true, length: { minimum: 1 }

  has_many :likes, dependent: :destroy

end

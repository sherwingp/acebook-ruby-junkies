# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments
  has_one_attached :image, dependent: :destroy, service: :local
  belongs_to :user

  validates :message, presence: true, length: { minimum: 1 }

  has_many :likes, as: :likeable, dependent: :destroy

end

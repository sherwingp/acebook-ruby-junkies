# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_one_attached :image, dependent: :destroy

  validates :body, presence: true, if: -> { image.blank? }

  has_many :likes, as: :likeable, dependent: :destroy
end

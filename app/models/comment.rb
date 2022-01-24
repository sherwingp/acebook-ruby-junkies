# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_one_attached :image, dependent: :destroy, service: :local

  validates :body, presence: true, if: -> { |c| c.image.blank? }
end

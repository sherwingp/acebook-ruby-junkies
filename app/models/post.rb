# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, :dependent => :destroy
  has_one_attached :image, :dependent => :destroy
  belongs_to :user

  validates :message, presence: true, if: -> { image.blank? }

  has_many :likes, as: :likeable, dependent: :destroy

end

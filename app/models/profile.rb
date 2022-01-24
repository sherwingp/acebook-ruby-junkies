# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :users
  validates :about, presence: true, length: { minimum: 1 }
  has_one_attached :image, dependent: :destroy, service: :local

end

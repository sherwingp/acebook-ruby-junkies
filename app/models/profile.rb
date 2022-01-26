# frozen_string_literal: true

class Profile < ApplicationRecord
  belongs_to :user

  validates :about, presence: true, length: { minimum: 1 }
  has_one_attached :avatar, dependent: :destroy, service: :local
end

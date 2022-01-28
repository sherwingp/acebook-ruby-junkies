# frozen_string_literal: true

class Gemlike < ApplicationRecord
  belongs_to :gemlikeable, polymorphic: true
  
  validates :user_id, presence: true
end

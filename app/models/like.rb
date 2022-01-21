class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  
  validates :post_id, presence: true
  validates :user_id, presence: true
end

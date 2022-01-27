# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_one_attached :image, dependent: :destroy, service: :local

  validates :body, presence: true, if: -> { image.blank? }

  has_many :likes, as: :likeable, dependent: :destroy

  after_create_commit :notify_recipient
  
  private
  
  def notify_recipient
    recipient = User.find(post.user_id)
    sender = User.find(user_id)
    commenter = "#{sender.name} #{sender.surname}"
    CommentNotification.with(message: self, post: post, commenter: commenter).deliver_later(recipient) unless recipient == sender
  end
end

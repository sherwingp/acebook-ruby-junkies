# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_one_attached :image, dependent: :destroy

  validates :body, presence: true, if: -> { image.blank? }

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :gemlikes, as: :gemlikeable, dependent: :destroy

  has_many :notifications, as: :recipient, dependent: :destroy
  has_noticed_notifications param_name: :parent, destroy: true, model_name: "Notification"

  after_create_commit :notify_recipient
  
  private
  
  def notify_recipient
    recipient = User.find(post.user_id)
    sender = User.find(user_id)
    commenter = "#{sender.name} #{sender.surname}"
    CommentNotification.with(parent: self, post: post, commenter: commenter).deliver_later(recipient) unless recipient == sender
  end
end

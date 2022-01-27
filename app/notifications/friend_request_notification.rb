# To deliver this notification:
#
# CommentNotification.with(post: @post).deliver_later(current_user)
# CommentNotification.with(post: @post).deliver(current_user)

class FriendRequestNotification < Noticed::Base
  # Add your delivery methods
  
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  def to_database
    {
      type: self.class.name,
      params: params,
      account: Current.account,
    }
  end

  # Add required params
  #
  param :requester

  # Define helper methods to make rendering easier.
  #
  def message
    t(".message", requester: params[:requester])
  end
  #
  def url
    users_profiles_path
  end
end

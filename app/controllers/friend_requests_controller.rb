class FriendRequestsController < ApplicationController
  before_action :set_friend_request, except: [:index, :create]

  def index
    unless current_user.profiles.exists?
      redirect_to '/'
    end
    @incoming = FriendRequest.where(friend: current_user)
    @requesters = @incoming.map { |request| User.find(request.user_id) }
    @outgoing = current_user.friend_requests
    @requestees = @outgoing.map { |request| User.find(request.friend_id) }
  end



  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)

    if @friend_request.save
      redirect_to '/users/profiles'
    else
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  def update
    @friend_request.accept
    redirect_to friend_requests_path
  end
  
  def destroy
    @friend_request.destroy
    redirect_to friend_requests_path
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end

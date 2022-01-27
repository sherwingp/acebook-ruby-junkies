class FriendsController < ApplicationController
  before_action :set_friend, only: :destroy

  def index
    @friends = current_user.friends
    @friends_all = Friend.all
  end

  def show
    @friend = Friend.find(params[:id]) if params[:id] != 'new'
  end

  def destroy
    current_user.friends.destroy(@friend)
    redirect_to users_profiles_path
  end

  private
  
  def set_friend
    @friend = current_user.friends.find(params[:id])
  end
end

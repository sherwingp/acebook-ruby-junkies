class FriendsController < ApplicationController
  def index
    @friends = Friend.all
  end

  def show
    @friend = Friend.find(params[:id]) if params[:id] != 'new'
  end
end

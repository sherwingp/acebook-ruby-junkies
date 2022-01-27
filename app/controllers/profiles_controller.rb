# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :check_for_existing_profile, only: [:new, :create]

  def index
    @profiles = Profile.all
    if params[:search_by_name] != "" && params[:search_by_name] != nil
      split_name = params[:search_by_name].split(" ")
      @users_searched = User.where('lower(name) = ?', split_name[0].downcase) && User.where('lower(surname) = ?', split_name[-1].downcase)
      if @users_searched.empty?
        if User.where('lower(name) = ?', split_name[0].downcase).empty? && User.where('lower(surname) = ?', split_name[-1].downcase).empty?
        return @profiles = ["No people match this search!"]
        else
            @users_searched_first_name  = User.where('lower(name) = ?', split_name[0].downcase)
            @ids = []
            @users_searched_first_name.each do |user|
              @ids << user.id
            end
            @users_searched_last_name  = User.where('lower(surname) = ?', split_name[-1].downcase)
            @users_searched_last_name.each do |user|
              @ids << user.id
            end
            @ids.uniq
          return @profiles = Profile.where(user_id: @ids)
        end
      else
        @ids = []
            @users_searched.each do |user|
              @ids << user.id
            end
            @users_searched_first_name  = User.where('lower(name) = ?', split_name[0].downcase)
            @ids = []
            @users_searched_first_name.each do |user|
              @ids << user.id
            end
            @users_searched_last_name  = User.where('lower(surname) = ?', split_name[-1].downcase)
            @users_searched_last_name.each do |user|
              @ids << user.id
            end
            @ids.uniq
        return @profiles = Profile.where(user_id: @ids)
      end
    end
  end

  def edit
    @profile = Profile.where(:user_id => current_user.id).first
  end

  def update
    @profile = Profile.where(:user_id => current_user.id).first

    if @profile.update(profile_params)
      redirect_to user_profile_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:user_id])
    @profile = @user.profiles if params[:id] != 'new'

    @posts = Post.where(:user_id => @user.id)
    @post_ids= []
    @posts.each do |post| @post_ids << post.id end
    @comments = Comment.where(:user_id => @user.id)
    @comments.each do |comment| @post_ids << comment.post_id end
    @posts_to_use = Post.find((@post_ids.uniq.sort_by { |number| -number }))

    @profiles_friends = User.find(@user.profiles.first[:user_id]).friends
    @we_are_friends = false 
    @profiles_friends.each do |friend|
      if friend.id == current_user.id
      @we_are_friends = true
      end
    end

    @outgoing = current_user.friend_requests
    @friend_request_sent = false
    @outgoing.each do |request|
      if request.friend_id == @user.profiles.first[:user_id]
      @friend_request_sent = true
      end
    end

    @friend_request_pending = FriendRequest.where(friend: current_user.id, user: @user.profiles.first[:user_id])
  end

  def new
    @profile= Profile.new
  end

  def create
    @user = User.find(current_user.id)
    @profile = @user.profiles.create(profile_params)
    redirect_to user_profile_path
  end

  private

  def profile_params
    params.require(:profile).permit(:about, :avatar)
  end

  def check_for_existing_profile
    @user = User.find(current_user.id)
    @profile = Profile.where(:user_id => current_user.id)
    if @profile.exists?
      redirect_to posts_url, notice: "Logged in successfully"
    end
    rescue ActiveRecord::RecordNotFound => e
      return "Not Found"
  end
end

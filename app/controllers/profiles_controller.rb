# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :check_for_existing_profile, only: [:new, :create]

  def index
    @profiles = Profile.all
    if params[:search_by_name] != "" && params[:search_by_name] != nil
      split_name = params[:search_by_name].split(" ")
      @users_searched = User.where(name: split_name[0], surname: split_name[1])
      if @users_searched.empty?
        if User.where(name: split_name[0]).empty? && User.where(surname: split_name[-1]).empty?
        return @profiles = ["No people match this search!"]
        else
            @users_searched_first_name  = User.where(name: split_name[0])
            @ids = []
            @users_searched_first_name.each do |user|
              @ids << user.id
            end
            @users_searched_last_name  = User.where(surname: split_name[-1])
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
            @users_searched_first_name  = User.where(name: split_name[0])
            @ids = []
            @users_searched_first_name.each do |user|
              @ids << user.id
            end
            @users_searched_last_name  = User.where(surname: split_name[-1])
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
    Cloudinary::Uploader.destroy(@profile.avatar.key) if @profile.avatar.key
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

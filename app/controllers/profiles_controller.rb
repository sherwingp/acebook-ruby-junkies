# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :check_for_existing_profile, only: [:new, :create]

  def index
    @profiles = Profile.all
  end

  def show
    @user = User.find(current_user.id)
    @profile = @user.profiles if params[:id] != 'new'
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

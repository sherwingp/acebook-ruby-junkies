# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :check_for_existing_profile, only: [:new, :create]

  def index
    @profile = Profile.all
  end

  def new
    @profile= Profile.new
  end

  def show
    @profile = Profile.find(params[:id]) if params[:id] != 'new'
    # redirect_to posts_url
  end

  def create
    @user = User.find(current_user.id)
    @profile = @user.profiles.create(profile_params)
    if @profile.save
      redirect_to profiles_url
    else
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:about, :avatar)
  end

  def check_for_existing_profile
    @user = User.find(current_user.id)
    p Profile.find(current_user.id)
    if Profile.find(current_user.id)
      # redirect_to posts_url, notice: 'Profile already exists'
    end
  end
end

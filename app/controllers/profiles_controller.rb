# frozen_string_literal: true

class ProfilesController < ApplicationController

  def index
    @profile = Profile.all
  end

  def new
    @profile= Profile.new
  end

  def show
    @profile = Profile.find(params[:id]) if params[:id] != 'new'
  end

  def create
    @user = User.find(current_user.id)
    @profile = @user.profiles.create(profile_params)
    @profile.save
    redirect_to profiles_url
  end

  private

  def profile_params
    params.require(:profile).permit(:about, :avatar)
  end

end

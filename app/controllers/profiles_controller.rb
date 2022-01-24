class ProfilesController < ApplicationController

  def new
    @profile = Profile.new
  end

  def show
    @profile = Profile.find(params[:id]) if params[:id] != 'new'
  end

  def create
    @user = User.find(current_user.id)
    @profile = @user.profile.create(post_params)
  end

  private

  def post_params
    params.require(:profile).permit(:about)
  end

end

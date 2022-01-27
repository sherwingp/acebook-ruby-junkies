class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def show
    @notifications = current_user.notifications
  end
end
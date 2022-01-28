class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def show
    unless current_user.profiles.exists?
      redirect_to '/'
    end
    @notifications = current_user.notifications
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    flash[:notice] = "Notification successfully deleted!"
    redirect_to user_notifications_path(current_user.id)
  end

  def destroy_all
    Notification.delete_all
    flash[:notice] = "All notifications successfully deleted!"
    redirect_to user_notifications_path(current_user.id)
  end
end

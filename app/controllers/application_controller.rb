# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :count_notifications
  protect_from_forgery prepend: true

  private
  def count_notifications
      @notification_count = current_user.notifications.count if user_signed_in? 
  end
end

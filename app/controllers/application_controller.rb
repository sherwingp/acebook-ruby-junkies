# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :count_notifications
  protect_from_forgery with: :exception

  private
  def count_notifications
    @notification_count = Notification.count
  end
end

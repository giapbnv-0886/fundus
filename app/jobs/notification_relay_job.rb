class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform notification
    html = ApplicationController.render partial: "notifications/notification", locals: {notification: notification}
    ActionCable.server.broadcast "notifications_#{notification.user_id}", {message: notification.notice, url: url_for(notification.notifiable), html: html}
  end
end

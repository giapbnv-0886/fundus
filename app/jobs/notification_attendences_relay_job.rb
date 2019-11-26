class NotificationAttendencesRelayJob < ApplicationJob
  queue_as :default

  def perform event
    users = event.users
    return if user&.blank?
    users.each do |user|
      Notification.create user_id: user.id, notifiable: event, notice: t("event.notification.notice.incoming", title: event.title, time: event.start_time)
    end
  end
end

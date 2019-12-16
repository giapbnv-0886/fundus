class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :get_actions, ->{@activities = PublicActivity::Activity.all.where(owner_type: "User").order created_at: :desc}
  scope :get_notifications, ->{@notifications = current_user.notifications.latest}
end

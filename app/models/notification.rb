class Notification < ApplicationRecord
  validates :notice, presence: true, length: {maximum: 255}
  validates :notifiable_id, presence: true
  validates :notifiable_type, presence: true

  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  scope :latest, -> { order :read, created_at: :desc}

  after_create -> {NotificationRelayJob.perform_later(self)}
end

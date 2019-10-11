class Attendance < ApplicationRecord
  CSV_ATTRIBUTES = %w(id user_name user_email created_at)

  belongs_to :event
  belongs_to :user

  validates :user_id, presence: true
  validates :event_id, presence: true
  validates :event_id, uniqueness: {scope: :user_id}

  delegate :id, :name, :email, to: :user, prefix: true, allow_nil: true
  delegate :title, :place, :start_time, :end_time, to: :event, prefix: true, allow_nil: true
end

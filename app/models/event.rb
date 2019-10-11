class Event < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :active_attendances, class_name: "Attendance", foreign_key: "event_id", dependent: :destroy
  has_many :users, through: :active_attendances

  validates :title, presence: true, length: {maximum: 100}
  validates :place, presence: true, length: {maximum: 150}
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :content, presence: true, length: {maximum: 200}
  validates :expiration_date, presence: true
  validate :compareDate

  scope :sort_by_created, ->{order created_at: :desc}

  def compareDate
    if end_time < start_time
      errors.add(:end_time, t("event.model.time1"))
    elsif end_time < Date.today || start_time < Date.today
      errors.add(:end_time, t("event.model.time1"))
    elsif start_time < expiration_date
      errors.add(:start_time, t("event.model.time1"))
    end
  end

  def unattend? user
    Attendance.find_by(user_id: user.id, event_id: self.id).destroy
  end

  def attendance user
    users << user
  end

  def attendance? user
    users.include? user
  end

  def expirationTime?
    self.expiration_date < Date.today
  end

  def belong? user
    self.user == user
  end
end

class Category < ApplicationRecord
  has_many :blogs, dependent: :destroy
  has_many :causes, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :donations, through: :causes, dependent: :nullify

  validates :name, presence: true

  def count_element
    self.causes.count + self.blogs.count + self.events.count
  end

  def donations_of user
    donations.where(user_id: user.id)
  end

  def total_amount_of user
    donations.where(user_id: user.id).where.not(purchased_at: nil).sum(:amount)
  end

  def total_amount_by_week_of user
    donations.where(user_id: user.id).where.not(purchased_at: nil).group_by_week(:purchased_at).sum(:amount)
  end

  def total_amount_by_month_of user
    donations.where(user_id: user.id).where.not(purchased_at: nil).group_by_month(:purchased_at).sum(:amount)
  end
end

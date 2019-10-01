class Donation < ApplicationRecord
  belongs_to :user
  belongs_to :cause

  validates :user_id, presence: true
  validates :cause_id, presence: true
  validates :amount, presence: true

end

class Cause < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :donations, dependent: :destroy

  scope :sort_by_created, ->{order created_at: :desc}
end

class Category < ApplicationRecord
  has_many :blogs, dependent: :destroy
  has_many :causes, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :name, presence: true
end

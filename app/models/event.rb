class Event < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :attendances, dependent: :destroy
  has_many :attendedusers, through: :attendances, source: :user
end

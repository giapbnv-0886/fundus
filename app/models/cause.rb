class Cause < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :donation, dependent: :destroy
end

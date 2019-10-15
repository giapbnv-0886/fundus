class Blog < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 140}
  validates :content, presence: true

  scope :sort_by_created, ->{order created_at: :desc}
  scope :recent_post, -> {limit 3}
end

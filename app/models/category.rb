class Category < ApplicationRecord
  has_many :blogs, dependent: :destroy
  has_many :causes, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :name, presence: true

  def count_element
    self.causes.count + self.blogs.count + self.events.count
  end
end

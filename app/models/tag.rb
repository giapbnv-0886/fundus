class Tag < ApplicationRecord
  belongs_to :blog, optional: true
  has_and_belongs_to_many :events
  has_and_belongs_to_many :causes

  validates :name, presence: true

  def count_element
    self.blogs.count + self.events.count + self.causes.count
  end
end

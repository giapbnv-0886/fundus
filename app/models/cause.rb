class Cause < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: %i(slugged finders)

  acts_as_paranoid

  belongs_to :category, touch: true
  belongs_to :user, touch: true
  has_many :events, dependent: :destroy
  has_many :blogs, dependent: :destroy
  has_many :donations, dependent: :destroy
  has_and_belongs_to_many :tags

  delegate :name, :email, to: :user, prefix: true, allow_nil: true

  validates :title, presence: true, length: {maximum: 140}
  validates :end_time, presence: true
  validates :detail, presence: true
  validate :check_time

  after_commit :create_hash_tags, on: :create

  scope :sort_by_created, -> { order created_at: :desc }
  scope :recent_post, -> { limit 3 }

  def check_time
    if end_time < Date.today
      errors.add(:end_time, t("cause.model.errorTime"))
    end
  end

  def belong? user
    self.user == user
  end

  def create_hash_tags
    cause = Cause.find_by id: self.id
    hashtags = self.detail.scan(/#\w+/)
    hashtags.uniq.map do |hashtag|
      tag = Tag.find_or_create_by name: hashtag.downcase.delete('#')
      cause.tags << tag
    end
  end

  def should_generate_new_friendly_id?
    slug.blank? || title_changed? || super
  end
end

class Blog < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: %i(slugged finders)

  acts_as_paranoid

  belongs_to :user, optional: true, touch: true
  belongs_to :category, optional: true, touch: true
  belongs_to :cause, touch: true
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags
  validates :user_id, presence: true

  delegate :user, :user_name, :user_email, to: :cause, prefix: true, allow_nil: true

  validates :title, presence: true, length: {maximum: 140}
  validate :limit_tags

  scope :sort_by_created, ->{order created_at: :desc}
  scope :recent_post, -> {limit 3}

  after_commit :create_hash_tags, on: :create
  before_commit :update_hash_tags, on: :update

  def limit_tags
    if hash_tag.scan(/\w+/).length > 5
      errors.add(:hash_tag, t("blog.model.tags"))
    end
  end

  def create_hash_tags
    blog = Blog.find_by id: self.id
    hashtags = self.hash_tag.scan(/\w+/)
    hashtags.uniq.map do |hashtag|
      tag = Tag.find_or_create_by name: hashtag.downcase.delete("#")
      blog.tags << tag
    end
  end

  def update_hash_tags
    blog = Blog.find_by id: self.id
    blog.tags.clear
    hashtags = self.content.scan(/\w+/)
    hashtags.uniq.map do |hashtag|
      tag = Tag.find_or_create_by name: hashtag.downcase.delete("#")
      blog.tags << tag
    end
  end

  def should_generate_new_friendly_id?
    slug.blank? || title_changed? || super
  end
end

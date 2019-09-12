class User < ApplicationRecord
  has_many :blogs, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :causes, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
           foreign_key: "follower_id",dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
           foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :attendances, dependent: :destroy
  has_many :attendedevents, through: :attendances, source: :event

  before_save {email.downcase!}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: {minimum: 6}

  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end

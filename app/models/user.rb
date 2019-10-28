class User < ApplicationRecord
  AUTHORITIES = {admin: "admin", founder: "founder", member: "member"}.freeze
  enum role: AUTHORITIES

  acts_as_paranoid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable,
         :omniauthable, omniauth_providers: %i(facebook)

  has_many :causes, dependent: :destroy
  has_many :blogs, through: :causes, dependent: :destroy
  has_many :events, through: :causes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
           foreign_key: "follower_id",dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
           foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :attendances, dependent: :destroy
  has_many :attend_events, through: :attendances, source: :event
  has_many :donations, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50}

  def cached_causes
    c_causes = Rails.cache.fetch([cache_key, updated_at.to_i.to_s, __method__.to_s]) do
      causes
    end
    reflection = self.class.reflect_on_association(:causes)
    if association_instance_get(name).nil?
      association = reflection.association_class.new(self, reflection)
      association.target = c_causes
      association_instance_set(:causes, association)
    end
    c_causes
  end

  class << self
    def from_omniauth auth
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.email = auth.info.email
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name
        user.photo = URI.parse auth.info.image
        user.skip_confirmation!
      end
    end

    def new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end
end

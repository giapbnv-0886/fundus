class Donation < ApplicationRecord
  CSV_ATTRIBUTES = %w(id user_name user_email amount description purchased_at)

  acts_as_paranoid

  belongs_to :user
  belongs_to :cause

  validates :user_id, presence: true
  validates :cause_id, presence: true
  validates :amount, presence: true

  scope :purchased, -> { where.not purchased_at: nil }

  delegate :name, :email, to: :user, prefix: true, allow_nil: true
  delegate :title, :category, to: :cause, prefix: true, allow_nil: true

  def token=(token)
    self[:token] = token
    if new_record? && !token.blank?
      details = EXPRESS_GATEWAY.details_for(token)
      self.payer_id = details.payer_id
      self.amount= details.params["order_total"]
      self.description = details.params["description"]
    end
  end

  def purchase
    response = EXPRESS_GATEWAY.purchase(self.amount, purchase_options)
    self.update_attributes purchased_at: DateTime.now if response.success?
    response.success?
  end

  private
  def purchase_options
    {
        token: self.token,
        payer_id: self.payer_id
    }
  end
end

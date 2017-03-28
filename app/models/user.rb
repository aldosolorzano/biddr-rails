class User < ApplicationRecord
  has_secure_password
  has_many :auctions, dependent: :destroy
  has_many :bids, dependent: :destroy
  has_many :bid_auctions, through: :bids, source: :auction

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
validates :email, presence: true,
                  format: VALID_EMAIL_REGEX,
                  uniqueness: true

  def full_name
    "#{first_name} #{last_name}".strip.titleize
  end
  private

  def downcase_email
    self.email&.downcase!
  end

end

class Auction < ApplicationRecord
  belongs_to :user
  has_many :bids, dependent: :destroy
  has_many :bidders, through: :bids, source: :user

  validates :title, presence:true,
                    uniqueness: {case_sensitive: false},
                    exclusion: {in: %w(Microsoft Apple Sony)}
  validates :reserve_price, numericality: {greater_than:0}
  validates :details, presence:true,
                          length:{minimum:10}
  validates :bid_price, numericality: {greater_than:0}

  before_validation:set_bid_price

  def set_bid_price
    self.bid_price ||= 1;
  end

end

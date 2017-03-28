class Auction < ApplicationRecord
  belongs_to :user
  has_many :bids, dependent: :destroy
  has_many :bidders, through: :bids, source: :user

  has_many :watches, dependent: :destroy
  has_many :watchers, through: :watches, source: :user

  validates :reserve_price, numericality: {greater_than:0}
  validates :details, presence:true,
                          length:{minimum:10}
  validates :bid_price, numericality: {lower_than: :previous_bid}
  before_validation:set_bid_price


  def previous_bid
    self.bids.last.amount ||=0
  end

  def watch_by?(user)
    watches.exists?(user: user)
  end

  def set_bid_price
    self.bid_price ||= 1;
  end

end

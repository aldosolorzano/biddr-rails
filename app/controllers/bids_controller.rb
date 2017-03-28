class BidsController < ApplicationController
  def create
    auction = Auction.find params[:auction_id]
    bid = Bid.new amount:params[:amount]
    bid.user = current_user
    bid.auction = auction

    if bid.save
      bid_sum = auction.bid_price + params[:amount].to_f
      auction.update bid_price:bid_sum
      redirect_to auction_path(auction), notice: 'Thank\'s for bidding'
    else
      byebug
      redirect_to auction_path(auction)
    end
  end

end

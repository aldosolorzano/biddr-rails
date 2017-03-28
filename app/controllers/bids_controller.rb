class BidsController < ApplicationController
  before_action :authorize,only:[:create]

  def create
    auction = Auction.find params[:auction_id]
    bid = Bid.new amount:params[:amount]
    bid.user = current_user
    bid.auction = auction

    if bid.save
      auction.update bid_price:params[:amount]
      redirect_to auction_path(auction), notice: 'Thank\'s for bidding'
    else
      redirect_to auction_path(auction)
    end
  end

private

  def authorize
      auction = Auction.find params[:auction_id]
      if current_user == auction.user
        redirect_to auction_path(auction),alert: 'You Can\'t bid your auction'
    end
  end
end

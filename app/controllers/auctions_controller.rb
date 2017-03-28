class AuctionsController < ApplicationController
  def index
    @auctions = Auction.order(created_at: :desc)
  end
  def show
    @auction = Auction.find params[:id]
  end
  def new
    @auction = Auction.new
  end

  def create
    auction_params = params.require(:auction).permit(:title,:details,:ends_on,:reserve_price)
    @auction = Auction.new auction_params
    @auction.user = current_user

    if @auction.save
      redirect_to auction_path(@auction)
    else
      render :new
    end
  end

  def edit
    @auction = Auction.find params[:id]
  end

  def update
    auction_params = params.require(:auction).permit(:title,:details,:ends_on,:reserve_price)

    @auction = Auction.find params[:id]
    if @auction.update auction_params
      redirect_to auction_path(@auction)
    else
      render :edit
    end
  end

  def destroy
  end
end

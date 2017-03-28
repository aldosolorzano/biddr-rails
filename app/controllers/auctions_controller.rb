class AuctionsController < ApplicationController
  before_action :find_auction,only:[:show,:destroy,:edit]
  before_action :authenticate_user!, except:[:index,:show]
  before_action :authorize, only: [:edit,:destroy,:update]


  def index
    @auctions = Auction.where(aasm_state: 'published').order(created_at: :desc)
  end

  def show
    @watch = @auction.watches.find_by(user: current_user)
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
  end

  def update

    if params[:publish]
      @auction.publish
      @auction.save
      redirect_to auction_path(@auction)
      return
    end

    auction_params = params.require(:auction).permit(:title,:details,:ends_on,:reserve_price)
    if @auction.update auction_params
      redirect_to auction_path(@auction)
    else
      render :edit
    end
  end

  def destroy
    @auction.destroy
    redirect_to root_path,notice:'auction deleted'
  end


  private

  def find_auction
    @auction = Auction.find params[:id]
  end

  def authorize
    @auction = Auction.find params[:id]
    if cannot?(:manage,@auction)
      redirect_to auction_path(@auction),notice: 'You can\'t'
    end
  end
end

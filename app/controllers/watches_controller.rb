class WatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_auction,only:[:create]
  before_action :find_watch,only:[:destroy]

  def create
    watch = Watch.new(user:current_user,auction:@auction)
    # if cannot?(:fav,@auction)
    #   redirect_to auction_path(@auction),alert: 'you cant tho'
    #   return
    # end

    redirect_to(
      auction_path(@auction),
      watch.save ? {notice:'Saved to watching auctions'} : {alert:'not saved'}
    )
  end

  def destroy
    # if cannot?(:fav,@watch.auction)
    #   redirect_to auction_path(@watch.auction),alert:'you cant'
    #   return
    # end
    redirect_to(
      auction_path(@watch.auction),
      @watch.destroy ? {notice: 'Remove from fav'} :
                          {alert: @watch.errors.full_messages.join(', ') }
    )
  end
  private

  def find_auction
    @auction ||= Auction.find(params[:auction_id])
  end

  def find_watch
    @watch ||= Watch.find(params[:id])
  end
end

require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
describe '#new with user authentication'do
  it 'render new template'do
    session[:user_id] = 1
    get :new
    expect(response).to render_template(:new)
  end
  it 'contain instance variable @auction' do
    session[:user_id] = 1
    get :new
    expect(assigns(:auction)).to be_a_new Auction
  end
end

end

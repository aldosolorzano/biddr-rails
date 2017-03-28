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

describe '#create' do
  context 'Wit valid attr' do
    it 'creates a new auction in db' do
      session[:user_id] = 1
      count_before = Auction.count
      post(:create, params: { auction: {
                            title: 'This is grate',
                            details: 'dflkmglfkmg dkjfnkjgnkfg',
                            reserve_price: 34,
                            ends_on:'2018-01-01'
                            }

                        })
      count_after = Auction.count
      expect(count_after).to eq(count_before+1)
    end
    it "redirects to root" do
      session[:user_id] = 1
      post(:create, params: { idea: {
                              title: 'This is grate',
                              description: 'dflkmglfkmg'
                              }

                          })
      expect(response).to redirect_to(idea_path(Idea.last))
    end
  end

  context 'with invalid attr'do
  it 'doesnt creates a new idea in db' do
    count_before = Idea.count
    post(:create, params: { idea: {
                            title: 'This is grate',
                            description: ''
                            }
                        })
    count_after = Idea.count
    expect(count_before).to eq(count_after)
  end
    it 'renders :new' do
      post(:create, params: { idea: {
                              title: 'This is grate',
                              description: ''
                              }
                          })
      expect(response).to render_template(:new)
    end
  end
end


end

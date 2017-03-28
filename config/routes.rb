Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root'auctions#index'
  get '/users/watching' => "users#index"
  resources :auctions,shallow:true do
    resources :bids,only:[:create]
    resources :watches,only:[:create,:destroy]
  end
  resources :users,only:[:create,:new]
  resources :sessions, only: [:new,:create] do
    delete :destroy, on: :collection
  end

end

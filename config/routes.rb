Trixie::Application.routes.draw do
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users, :only => :show
  resources :distress, :only => [:new, :create, :show]
  
  resources :users do
    resources :emergency_contacts
  end
end

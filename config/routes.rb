Rails.application.routes.draw do
  resources :posts
  get 'users/update_password'
  root "static_page#home"
  devise_for :users, controllers: { registrations: 'registrations' }

  get 'registrations/update_resource'
  get 'home', to: "static_page#home"

  scope :admin do
    resources 'users'
    get   'users/new', to: "users#new"
  end
  
  resource :users, only: [:change_password] do
    collection do
      get   'change_password'
      patch 'update_password'
    end
  end
end

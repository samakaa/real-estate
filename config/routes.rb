Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'home/index'
 devise_for :users, controllers: { sessions: 'sessions', registrations: 'users/registrations' }



resources :properties do
  member do
    delete :remove_image
  end
end

get 'search', to: 'search#index', as: 'search'


   direct :rails_blob do |blob|
    route_for(:rails_blob, blob)
   end
 root "home#index"
  get 'properties/index'
  get 'properties/show'
  get 'properties/new'
  get 'properties/create'
  get 'properties/edit'
  get 'properties/update'
  get 'properties/destroy', to: 'properties#destroy'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

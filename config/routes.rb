Rails.application.routes.draw do

  root 'home#index'
  get 'home/index'

  resources :books do
    member do
      get :delete
    end
  end

  
  # get 'books/index'
  # get 'books/show'
  # get 'books/new'
  # get 'books/edit'
  # get 'books/delete'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

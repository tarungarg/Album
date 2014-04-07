DemoApp::Application.routes.draw do
  root :to => 'albums#index'
  devise_for :users
  resources :albums, only: [:create, :show, :new, :destroy, :index] do
  	member do
  		delete "delete_image"
  	end
  end
end

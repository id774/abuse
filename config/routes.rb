RailsApp::Application.routes.draw do
  root :to => 'statuses#new'
  resources :admins,
    :only => [:new, :create]
  resources :statuses,
    :only => [:index, :show, :new, :create]
  resources :results,
    :only => [:index]
end

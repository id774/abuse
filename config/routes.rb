Rails4Bootstrap::Application.routes.draw do
  root :to => 'statuses#new'
  resources :statuses,
    :only => [:index, :show, :new, :create]
  resources :results,
    :only => [:index]
end

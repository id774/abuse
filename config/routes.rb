RailsApp::Application.routes.draw do
  root :to => 'statuses#new'
  resources :statuses,
    :only => [:new, :create, :index, :show, :edit, :update]
  resources :results,
    :only => [:index, :show]
  match '*path', :to=>'application#error_404'
end

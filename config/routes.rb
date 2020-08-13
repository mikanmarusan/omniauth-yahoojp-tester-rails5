Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '/top' => 'sessions#top', :via => :get
  match '/auth/:provider/callback' => 'sessions#callback', :via => :get
end

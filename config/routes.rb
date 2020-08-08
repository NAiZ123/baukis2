Rails.application.routes.draw do
#  namespace :staff, path: "" do
#    root "top#index"
#    get "login" => "sessions#new", as: :login
    #post "session" => "sessions#create", as: :session
    #delete "session" => "sessions#destroy"
    #resource :account    
#    resource :session, only: [ :create, :destroy ]
#    resource :account, expect: [ :new, :create, :destroy ]
#  end

  config = Rails.application.config.baukis2

  #constraints host: "baukis2.example.com" do
  constraints host: config[:staff][:host] do
    #namespace :staff, path: "" do 
    namespace :staff, path: config[:staff][:path] do
      root "top#index"
      get "login" => "sessions#new", as: :login
      resource :session, only: [ :create, :destroy ]
      resource :account, expect: [ :new, :create, :destroy ]
    end
  end

  constraints host: config[:admin][:host] do
    namespace :admin, path: config[:admin][:path] do
      root "top#index"
      get "login" => "sessions#new", as: :login
      resource :session, only: [ :create, :destroy ]
      resources :staff_members do
        resources :staff_events, only: [ :index ]
      end
      resources :staff_events, only: [ :index ]
    end
  end


  constraints host: config[:customer][:host] do
    namespace :customer, path: config[:customer][:path] do
      root "top#index"
      #get "login" => "sessions#new", as: :login
    end
  end
end

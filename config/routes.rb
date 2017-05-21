Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    authenticated :user do
      root  'categories#index', as: :authenticated_root
    end

    unauthenticated :user do
      root 'home#index', as: :unauthenticated_root
    end
  end

  resources :categories do
    collection do
      get :manage_categories #for breadcrumbs
      get '/favorite' => :fav_category
    end
    member do
      get '/update' => :update_fav_category
    end
  end

  resources :topics do
    collection do
      get :manage_topics
      get '/favorite/list' => :link_topic
    end
    member do
      get '/category/topics' => :supply_topic
      get '/favorite' => :fav_topic
      get '/update' => :update_fav_topic
    end
  end

  resources :links do
    collection do
      get :manage_links
      get 'favorite/list' => :fav_link_all
    end
    member do
      get '/category/topic/links' => :get_link
      get '/favorite' => :fav_link
      get '/update' => :update_fav_link
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

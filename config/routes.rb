require 'resque/server'

Rails.application.routes.draw do
  mount Resque::Server.new, at: '/resque'

  mount_devise_token_auth_for 'User', at: '/auth', controllers: {
    token_validations: 'overrides/token_validations',
    confirmations:     'overrides/confirmations',
    passwords:          'devise_token_auth/passwords',
    sessions:          'overrides/sessions'
  }

  get '/home' => 'home#index'

  namespace :api do
    namespace :v1, defaults: { format: 'json' } do

      post 'pusher/auth' => 'pusher#auth'

      resource :me, controller: 'me' do
        member do
          get :timeline
          post :resend_confirmation
          put :onboard
        end

        # Clean up these routes - same routes are found under :users
        get 'friendship_requests' => 'friendship_requests#index'
        resources :friendship_requests do
          member do
            post :accept
            post :reject
          end
        end
      end

      resources :users do
        member do
          put :onboard
        end
        collection do
          get :check_username
          get :most_recent
        end

        delete 'friendship_requests' => 'friendship_requests#destroy'
        resources :friendship_requests do
          collection do
            post :accept
            post :reject
          end
        end

        delete 'friendships' => 'friendships#destroy'
      end

      resources :mhps do
        collection do
          get :most_recent
        end
      end

      resources :friends

      resources :resources

      resources :posts

      resources :comments do
        member do
          get :next_page
        end
      end

      resources :supports do
        collection do
          get :item_summaries
        end
      end

      resources :journal_entries

      post 'supports/toggle' => 'supports#toggle'

      resources :conversations do
        collection do
          get :inbox
          get :recipient_autocomplete
        end

        member do
          post :reply
        end
      end

      resource :timeline
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

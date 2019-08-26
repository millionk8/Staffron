require 'sidekiq/web'

Rails.application.routes.draw do
  mount Rapporteur::Engine, at: '/status'
  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'

  mount_devise_token_auth_for 'User', at: 'api/auth', controllers: {
    registrations: 'api/v1/overrides/registrations',
    token_validations: 'api/v1/overrides/token_validations',
    sessions: 'api/v1/overrides/sessions',
    confirmations: 'api/v1/overrides/confirmations'
  }

  namespace :api, defaults: { format: :json } do
    scope module: 'v1', constraints: ApiConstraints.new(version: 1, default: true) do

      devise_scope :user do
        post 'invitations' => 'invitations#create'
      end

      resources :apps, only: [:index, :show] do
        resources :user_memberships, only: [:index, :create]
        post '/packages/:package_uuid/subscribe' => 'app_memberships#create'
        delete '/cancel_subscription' => 'app_memberships#destroy'
      end
      resources :user_memberships do
        member do
          put 'update_role'
        end
        collection do
          get '/validate_invitation_token/:invitation_token' => 'user_memberships#validate_invitation_token'
        end
        member do
          put '/resend_invitation' => 'user_memberships#resend_invitation'
          delete '/remove_user_membership' => 'user_memberships#destroy'
        end
      end
      resources :categories, only: [:index, :create, :show, :update, :destroy] do
        member do
          put 'set_default'
        end
      end
      resources :comments, only: [:index, :create, :destroy]
      resources :companies, only: [:index, :create, :update, :destroy]
      resources :companies, only: [:show, :update] do
        member do
          get 'users'
        end
      end
      resources :invoices, only: [:index, :create, :show, :update, :destroy]
      get 'logs' => 'logs#index'
      post 'packages/:id/select' => 'packages#select'
      resource :policy, only: [:show, :create, :update] do
        member do
          put 'accept'
          delete '/:id' => 'policies#destroy'
        end
      end
      resources :profiles, only: [:create, :update]
      resources :ptos, only: [:index, :create, :show, :update, :destroy] do
        collection do
          post 'rejected'
          get 'pending'
        end
      end
      resources :pto_availabilities, only: [:destroy]
      resources :pto_availabilities, only: [:create] do
        collection do
          put '/' => 'pto_availabilities#update'
        end
      end

      resources :roles, only: [:index, :create, :show, :update, :destroy]
      resources :schedules, only: [:index, :create, :update, :destroy]
      resources :timesheets, only: [:index, :create, :show, :update, :destroy]  do
        collection do
          post 'rejected'
          get 'pending'
        end
      end
      resources :time_logs, only: [:index, :create, :update, :destroy] do
        resources :logs, only: [:index]
        collection do
          get 'allrunning'
          get 'running'
          post 'start'
          put 'stop'
        end
      end
      resources :users, only: [:index, :show, :create, :update, :destroy] do
        resources :schedules, only: [:index]
        resources :pto_availabilities, only: [:index]
      end
      resources :versions, only: [:index] do
        member do
          put 'revert'
        end
      end
    end
  end

end

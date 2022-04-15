Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
      post '/mail/:task_id', to: 'contacts#sending', as: :mail
      get 'alltask', to: 'tasks#index', as: :all_task
      get 'new_task', to: 'tasks#new'
      post 'new_task', to: 'tasks#create'
      get '/edit_task/:task_id', to: 'tasks#edit', as: :edit_task
      get '/task/:task_id', to: 'tasks#show', as: :show_task
      post '/task_total/:task_id', to: 'tasks#update_total', as: :task_total
      patch '/update_task/:task_id', to: 'tasks#update', as: :update_task
      delete '/delete_task/:task_id', to: 'tasks#destroy', as: :delete_task
    end
  end
end
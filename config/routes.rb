Rails.application.routes.draw do
  root to: "categories#index"
  get 'pages/user'
  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :categories do
    resources :tasks do
      patch 'toggle_completed', on: :member
      patch 'today_task_completed', on: :member
      patch 'toggle_task_completed', on: :member
      delete 'delete_task_today', on: :member
      delete 'delete_completed_task', on: :member
      get 'active', on: :collection, action: :active_tasks
      get 'completed', on: :collection, action: :completed_tasks
    end
    delete 'delete_all_tasks', on: :member
  end

  get 'tasks/today', to: 'tasks#today'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end

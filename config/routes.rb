Rails.application.routes.draw do

  root "pages#home"

  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :categories do
    resources :tasks do

      patch 'task_today_completed', on: :member
      patch 'category_task_completed', on: :member
      delete 'delete_task_today', on: :member
      delete 'delete_completed_task', on: :member , action: :clear_completed_category_task
      get 'active', on: :collection, action: :active_category_tasks
      get 'completed', on: :collection, action: :completed_category_tasks
    end
    delete 'delete_all_tasks', on: :member
  end

  get '/tasks/today', to: 'tasks#today'
  get 'tasks/today/active', to: 'tasks#active_today', as: 'today_active'
  get 'tasks/today/completed', to: 'tasks#completed_today', as: 'today_completed'
  delete 'tasks/today/clear_completed', to: 'tasks#clear_completed_today', as: 'today_clear_completed'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  match "*path", to: "application#render_404", via: :all
end

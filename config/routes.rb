Rails.application.routes.draw do
  resources :messages
  resources :projects do
    resources :tasks
  end
  resources :projects do
    resources :drops
  end
  
resources :projects do
  resources :inboxes do
    resources :messages
  end  
end
  


  get 'my_admin_projects', to: 'my_admin_projects#index'
  get 'project_admins/index'
  get 'project_admins/new'
  resources :projects do
    resources :project_admins
  end
  root to: 'projects#index'
  devise_for :users
end


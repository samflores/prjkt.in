Prjkt::Application.routes.draw do
  devise_for :users

  root :to => "projects#index"
  resources :projects
end

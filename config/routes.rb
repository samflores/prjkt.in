Prjkt::Application.routes.draw do
  root :to => "projects#index"
  resources :projects
  root :to => "projects#index"
end

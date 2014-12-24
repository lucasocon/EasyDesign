Rails.application.routes.draw do
  devise_for :usuarios, controllers: {omniauth_callbacks: "omniauth_callbacks",
                                      registrations: "registrations"}
  resources :usuario
  resources :posts
  resources :attachments
  
  get 'welcome/index'

  root 'welcome#index'

end

Rails.application.routes.draw do
  
  resources :attachments

  resources :posts

  devise_for :usuarios, controllers: {omniauth_callbacks: "omniauth_callbacks",
                                      registrations: "registrations"}
  resources :usuario
  post "usuario/follow"
  
  get 'welcome/index'
  root 'welcome#index'
end

Rails.application.routes.draw do
  root 'articles#index'
  get 'articles' => 'articles#search'
  get 'mypage' => 'mypage#search'
  get 'mypage/index'
  devise_for :users
  resources :articles
end

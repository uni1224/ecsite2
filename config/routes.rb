Rails.application.routes.draw do
 # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
scope module: :public do
  root to: "homes#top"
  get 'about', to: 'homes#about'
  get 'customers/mypage' => 'customers#show', as: 'mypage'
  get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
  patch 'customers/information' => 'customers#update', as: 'update_information'
  get 'customers/quit' => 'customers#quit', as: 'confirm_quit'
  put 'customers/information' => 'customers#update'
  patch 'customers/out' => 'customers#out', as: 'out_customer'
  resources :addresses, only: [:index, :edit,:create, :update, :destroy]
  resources :items, only: [:index, :show]
  resources :orders, only: [:new, :index, :show, :create] do
    collection do
      post 'confirm'
      get 'thanks'
    end
  end
  resources :cart_items, only:[:index, :create, :update, :destroy] do
    collection do
      delete 'destroy_all'
    end
  end
end
# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
namespace :admin do
  root to: "homes#top"
  resources :items, only: [:index, :show, :new, :create, :edit, :update]
  resources :customers, only: [:index, :show, :edit, :update]
  resources :genres, only: [:index, :create, :edit, :update]
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

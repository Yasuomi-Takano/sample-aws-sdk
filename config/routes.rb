Rails.application.routes.draw do
  resources :fileuploads, only: [:index, :create, :new]
end

Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homes#show"

  get '/autocomplete', to: 'utilities#autocomplete'
  resources :users, controller: :users, only: :create
  resources :customer_registrations, only: [:new, :create]
  resources :customers, only: [:index, :show] do
    resources :addresses, shallow: true
  end
  resources :invoices, only: [:update]
  resources :projects, only: [:new, :create, :index, :show] do
    resource :billing_address, only: [:new, :create, :edit, :update]
    resource :downloads, only: [:show]
    resource :envisage_job_sheet, only: [:show]
    resource :my_job_sheet, only: [:show]
    resource :shipping_address, only: [:new, :create, :edit, :update]
    resource :project_finaliser, only: [:new, :create]
    resource :status_changer, only: [:create]
    resources :discounts, only: [:new, :create, :destroy], shallow: true
    resources :invoices, only: [:index], shallow: true, controller: "project_invoices" do
      resource :invoice_download, only: [:show]
    end
    resources :percentage_invoices, only: [:new, :create]
    resources :print_jobs, except: [:index], shallow: true do
      resources :multiple_product_additions, only: [:new, :create]
      resources :account_managements, except: [:index, :show]
      resources :designs, except: [:index, :show]
      resources :job_specifications, except: [:index, :show]
      resources :labour_items, except: [:index, :show]
      resources :mileages, except: [:index, :show]
      resources :product_items, except: [:index, :show]
      resources :sundry_items, except: [:index, :show]
      resources :supporting_product_items, except: [:index, :show]
    end
  end

  namespace :customer do
    resources :invoices, only: [:show] do
      resource :payment, only: [:new, :create]
    end
  end

  # Clearance
  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end
  resources :passwords,
      controller: 'clearance/passwords',
      only: [:create, :new]
  resource :session,
      controller: 'clearance/sessions',
      only: [:create]
  resources :users,
      controller: 'clearance/users',
      only: Clearance.configuration.user_actions do
        resource :password,
          controller: 'clearance/passwords',
          only: [:create, :edit, :update]
      end
  get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  delete '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out'
  if Clearance.configuration.allow_sign_up?
    get '/sign_up' => 'clearance/users#new', as: 'sign_up'
  end
end

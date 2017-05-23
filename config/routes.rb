Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#show'

  get 'finances', to: 'homes#finances'

  namespace :financial_reports do
    get ':year/:month', to: 'monthly_overviews#show',
                        constraints: { year: /\d{4}/, month: /\d{1,2}/ },
                        as: :monthly_overview
    get 'archive', to: 'monthly_overviews#archive'
    resource :my_monthly, only: [:show]

    resource :projects, only: [] do
      get 'not-invoiced-in-full', to: 'projects#not_invoiced_in_full'
      get 'not-paid-in-full', to: 'projects#not_paid_in_full'
    end
  end

  get '/autocomplete', to: 'utilities#autocomplete'
  resources :users, controller: :users, only: :create
  resources :customer_registrations, only: [:new, :create]
  resources :customers, only: [:index, :show, :edit, :update] do
    resources :addresses, shallow: true
    resources :contacts, shallow: true, except: [:show]
  end
  namespace :envisage do
    resources :invoices, only: [:index, :update] do
      get 'download-invoice', on: :member
    end
    resources :paid_invoices, only: [:index]
    resources :unpaid_invoices, only: [:index]
  end

  namespace :my do
    resources :invoices, only: [:index, :update]
    resources :paid_invoices, only: [:index]
    resources :unpaid_invoices, only: [:index]
    resources :invoice_searches, only: [:create]
  end

  resources :quote_stages, path: 'quote-stages'

  resources :invoices, only: [:update]
  resources :projects do
    # changing status
    resource :archiver, only: [:create]
    resource :completer, only: [:create]
    resource :finaliser, only: [:new, :create]
    resource :quoter, only: [:create]
    resource :seller, only: [:create]

    resource :billing_address, only: [:new, :create, :edit, :update]
    resource :downloads, only: [:show]
    resource :envisage_job_sheet, only: [:show]
    resource :my_job_sheet, only: [:show]
    resource :shipping_address, only: [:new, :create, :edit, :update]
    resources :discounts, only: [:new, :create, :destroy], shallow: true
    resources :envisage_invoices, only: [:create], controller: 'project_envisage_invoices'
    resources :invoices, only: [:index], shallow: true, controller: 'project_invoices' do
      resource :invoice_download, only: [:show] do
        get 'summarised', on: :member
      end
    end
    resources :amount_invoices, only: [:new, :create]
    resources :percentage_invoices, only: [:new, :create]
    resources :print_jobs, except: [:index], shallow: true do
      post 'order', on: :collection
      resources :actual_costs, only: :index
      resources :multiple_product_additions, only: [:new, :create]
      resources :account_managements, except: [:index, :show]
      resources :designs, except: [:index, :show]
      resources :job_specifications, except: [:index, :show]
      resources :labour_items, except: [:index, :show]
      resources :mileages, except: [:index, :show]
      resources :my_service_items, except: [:index, :show]
      resources :product_items, except: [:index, :show]
      resources :sundry_items, except: [:index, :show]
      resources :supporting_product_items, except: [:index, :show]
    end
    resources :vehicle_wraps, only: :index, controller: 'project_vehicle_wraps'
    resources :vehicle_wrap_print_job_creations, only: [:create]
  end
  resource :project_search, only: [:create, :show] do
    collection do
      get 'sold_and_finalised', path: 'sold-and-finalised'
      get 'quoted_only', path: 'quoted-only'
    end
  end
  resources :vehicle_wraps, shallow: true do
    resources :vehicle_wraps_account_managements, except: [:show, :index], controller: 'vehicle_wraps/account_managements'
    resources :vehicle_wraps_designs, except: [:show, :index], controller: 'vehicle_wraps/designs'
    resources :vehicle_wraps_job_specifications, except: [:show, :index], controller: 'vehicle_wraps/job_specifications'
    resources :vehicle_wraps_labours, except: [:show, :index], controller: 'vehicle_wraps/labours'
    resources :vehicle_wraps_materials, except: [:show, :index], controller: 'vehicle_wraps/materials'
    resources :vehicle_wraps_mileages, except: [:show, :index], controller: 'vehicle_wraps/mileages'
    resources :vehicle_wraps_supporting_materials, except: [:show, :index], controller: 'vehicle_wraps/supporting_materials'
    resources :vehicle_wraps_sundry_items, except: [:show, :index], controller: 'vehicle_wraps/sundry_items'
  end

  namespace :customer do
    resources :invoices, only: [:show] do
      resource :payment, only: [:new, :create]
    end
  end

  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end
  # Clearance
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

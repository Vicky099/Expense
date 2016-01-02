Rails.application.routes.draw do
  
  devise_for :users, :controllers => { :registrations => "registrations" }
  
  devise_scope :user do
    root :to => "devise/sessions#new"
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  resources :dashboards do
    collection do
      
    end
  end
  
  resources :incomes do
    collection do
      get :category
      post :save_income_category
      get :all_income_category
    end
  end
  
  resources :expenses do
    collection do
      get :category
      post :save_expense_category
      get :all_expense_category
    end
  end
  
  resources :transaction_records do
    collection do
      get :total_balance
      get :report
      post :download_pdf
    end
  end
 
end

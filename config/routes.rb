Rails.application.routes.draw do

  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  resources :votes
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy] do
    delete :destroy, on: :collection
  end
  resources :questions do
    resources :votes, only: [:create, :update, :destroy]
    # This will define a route that will be '/questions/search' and will point to the questions controller 'search' action in that controller.
    # on: :collection makes the route not have an 'id' or 'question_id' on it.
    get :search, on: :collection

    # This will generate a route '/questions/:id/flag' and it will point to questions controller 'flag' action.
    # on: :member makes the route include an ':id' in it similar to the 'edit'.
    post :flag, on: :member

    post :mark_done

    # This will make all the answers routes nested within 'questions' which means all the answers routes will be prepended with '/questions/:question_id'.
    resources :answers, only: [:create, :destroy]

    resources :likes, only: [:create, :destroy]

  end

  resources :likes, only: [:index]
  # get    "/questions/new"        => "questions#new",     as: :new_question
  # post   "/questions"            => "questions#create",  as: :questions
  # get    "/questions/:id"        => "questions#show",    as: :question
  # get    "/questions"            => "questions#index"
  # get    "/questions/:id/edit"   => "questions#edit",    as: :edit_question
  # patch   "/questions/:id"       => "questions#update"
  # delete "/questions/:id"        => "questions#destroy"
  # this defines a route that specifies if we get a request that has a GET
  # HTTP VERB with '/about' url, use the HomeController with about action (method)
  get "/about"  => "home#about"
  # passing the 'as:' option enables us to have a url/path helper for this route
  # note that helpers are only for the URL portion of the route and has nothing
  # to do with the HTTP verb. Also note that a URL helper must be unique
  get "/greet/:name" => "home#greet", as: :greet
  get  "/cowsay" => "cowsay#index"
  post "/cowsay" => "cowsay#create", as: :cowsay_submit
  get  "/temp_converter" => "temp_converter#index"
  post "/temp_converter" => "temp_converter#create"
  # get "/"       => "home#index"
  root "home#index"


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

ActionController::Routing::Routes.draw do |map|
  map.resources :admin_sessions

  map.login "login", :controller => 'admin_sessions', :action => 'new'
  map.logout "logout", :controller => 'admin_sessions', :action => 'destroy'
  
  map.connect '/clubs/:club_id/admin/:action', :controller => 'admin_pages'
  map.connect '/search/:query/', :controller => 'search', :action => 'search'
  map.connect '/search/clubs/:club_id/query/:query/', :controller => 'search', :action => 'search'
  map.connect '/search', :controller => 'search', :action => 'advanced'
  map.connect '/search/:query/', :controller => 'search', :action => 'advanced'
  
  map.formatted_search "/search.:format", :controller => "search", :action => "index", :method => :get 

  map.resources :admin_sessions
  map.resources :clubs, :collection => { :admin => :get } do |club|
    club.resources  :files,
                    :controller => "download_folders",
                    :has_many => :downloads,
                    :member => { :admin => :get },
                    :collection => { :admin => :get }
    
    club.resources  :gallery,
                    :controller => "albums",
                    :singular => "album",
                    :has_many => :images,
                    :member => { :admin => :get },
                    :collection => { :admin => :get }
    
    club.resources :admin, :controller => 'admin_pages'
		
    club.resources  :pages,
                    :controller => "pages",
                    :member => { :admin => :get },
                    :collection => { :admin => :get }
    
    club.resources  :groups,
                    :member => { :kick => :delete, :admin => :get },
                    :collection => { :add_member => :get, :create_membership => :post, :admin => :get }
                    
    club.resources  :events,
                    :member => { :admin => :get, :export_events => :get },
                    :collection => { :admin => :get, :export_events => :get }
    
    club.resources  :small_posts,
                    :member => { :admin => :get },
                    :collection => { :admin => :get }  
                    
    club.resources  :large_posts,
                    :member => { :admin => :get },
                    :collection => { :admin => :get }  
                    
  end 

  map.calendar "/calendar/:year/:month",
           :controller => "calendar",
           :action => "index",
           :year => Time.now.year,
           :month => Time.now.month


  map.resources :admins,
  	:updates,
		:images,
		:downloads,
		:users,
    :tags

	
  map.connect '/about', :controller => 'hub_pages', :action => 'about'
  map.connect '/digest', :controller => 'hub_pages', :action => 'digest'
  map.connect '/calendar', :controller => 'hub_pages', :action => 'calendar'
  map.connect '/map', :controller => 'hub_pages', :action => 'map'
  map.connect '/services', :controller => 'hub_pages', :action => 'services'
  
  # map.connect 'albums/:id/add', :controller => 'images', :action => 'new'


  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
   map.root :controller => "hub_pages"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

class ClubSweeper < ActionController::Caching::Sweeper
  observe Club
  
  def after_update(club)
    expire_cache(club)
  end
  
  def after_destroy(club)
    expire_cache(club)
  end
  
  def expire_cache(club)
    expire_page(:controller => 'clubs', :action => 'index')
    expire_page(:controller => 'hub_pages', :action => 'services')
  end
end
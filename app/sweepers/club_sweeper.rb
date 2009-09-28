class ClubSweeper < ActionController::Caching::Sweeper
  observe Club
  
  def after_save(club)
    expire_calendar(club)
  end
  
  def after_update(club)
    expire_cache(club)
  end
  
  def after_destroy(club)
    expire_cache(club)
    expire_calendar(club)
  end
  
  def expire_cache(club)
    expire_page(:controller => 'clubs', :action => 'index')
    expire_page(:controller => 'hub_pages', :action => 'services')
  end
  
  def expire_calendar(club)
    expire_page(:controller => 'hub_pages', :action => 'calendar')
  end
end
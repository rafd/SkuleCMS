class AdminPagesController < ApplicationController
  before_filter :load_club, :auth_admin
  
  def index
    @site_section = "admin"
    @page_title = "Dashboard"
    @quick_update = @club.small_posts.new
  
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clubs }
    end
  end
  
  def dashboard
  
  end
  
  #posts
  #events
  #photos
  #pages
  #members
  #files
  #setting
  
end

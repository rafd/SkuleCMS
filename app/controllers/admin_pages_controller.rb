class AdminPagesController < ApplicationController
  before_filter :load_club, :auth_admin
  def load_club
    @club = Club.find(params[:club_id])
  end
  
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clubs }
    end
  end
  
  def dashboard
  
  end
  
  def posts
  
  end
  
  def events
  
  end
  
  def photos
  
  end
  
  def pages
  
  end
  
  def members
  
  end
  
  def files
  
  end
  
  def settings
  
  end
  
end

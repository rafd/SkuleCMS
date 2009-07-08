class AdminPagesController < ApplicationController
  before_filter :load_club
  def load_club
    @club = Club.find(params[:club_id])
  end
  
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clubs }
    end
  end
end

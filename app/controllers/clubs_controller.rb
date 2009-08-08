class ClubsController < ApplicationController
  before_filter :auth_admin, :only => [:edit, :update]
  before_filter :auth_new_club, :only => [:new, :create]
  # GET /clubs
  # GET /clubs.xml
  def index
    @clubs = Club.find(:all, :include => :tags)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @clubs }
    end
  end
  
  def admin
  	@clubs = Club.all
  end

  # GET /clubs/1
  # GET /clubs/1.xml
  def show
    @club = Club.find(params[:id], :include => :tags)
 
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @club }
    end
  end

  # GET /clubs/new
  # GET /clubs/new.xml
  def new
    @club = Club.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @club }
    end
  end

  # GET /clubs/1/edit
  def edit
    @club = Club.find(params[:id], :include => :tags)
  end

  # POST /clubs
  # POST /clubs.xml
  def create
    @club = Club.new(params[:club])
    @club.web_name = @club.name

    respond_to do |format|
      if @club.save
        current_admin.club_id = @club.id
        current_admin.save
        flash[:notice] = 'Club was successfully created.'
        format.html { redirect_to(@club) }
        format.xml  { render :xml => @club, :status => :created, :location => @club }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @club.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clubs/1
  # PUT /clubs/1.xml
  def update
    @club = Club.find(params[:id], :include => :tags)

    respond_to do |format|
      if @club.update_attributes(params[:club])
        flash[:notice] = 'Club was successfully updated.'
        format.html { redirect_to(@club) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @club.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clubs/1
  # DELETE /clubs/1.xml
  def destroy
    @club = Club.find(params[:id])
    @club.destroy

    respond_to do |format|
      format.html { redirect_to(clubs_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def auth_admin
    if current_admin.blank?
      redirect_to login_path
    elsif !current_admin.club_id.blank? && current_admin.club_id.to_s != params[:id]
      redirect_to club_admin_index_path(current_admin.club_id)
    elsif current_admin.club_id.blank?
      redirect_to new_club_path
    end
  end
  
  def auth_new_club
    if current_admin.blank?
      redirect_to login_path
    elsif !current_admin.club_id.blank?
      redirect_to club_admin_index_path(current_admin.club_id)
    end
  end
end

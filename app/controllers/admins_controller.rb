class AdminsController < ApplicationController
  before_filter :auth_change, :only => [:change_password, :update_password]
  
  def index
    @admins = Admin.all
  end

  # GET /admins/1
  # GET /admins/1.xml
  def show
    @admin = Admin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin }
    end
  end

  # GET /admins/new
  # GET /admins/new.xml
  def new
    @admin = Admin.new
    @clubs = Club.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin }
    end
  end

  # GET /admins/1/edit
  def edit
    @admin = Admin.find(params[:id])
    @clubs = Club.all
  end

  # POST /admins
  # POST /admins.xml
  def create
    @admin = Admin.new(params[:admin])
    @admin.event = @admin.updates = @admin.member = @admin.group = @admin.file = @admin.gallery = false
    respond_to do |format|
      if @admin.save
        flash[:notice] = 'Registered admin.'
        format.html { redirect_to((@admin.club_id.blank?)? new_club_path: club_admin_index_path (current_admin.club_id)) }
        format.xml  { render :xml => @admin, :status => :created, :location => @admin }
      else
        @clubs = Club.all
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admins/1
  # PUT /admins/1.xml
  def update
    @admin = Admin.find(params[:id])

    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        flash[:notice] = 'Admin was successfully updated.'
        format.html { redirect_to(root_url) }
        format.xml  { head :ok }
      else
        @clubs = Club.all
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def change_password
    @admin = current_admin
  end
  
  def update_password
    @admin = current_admin

    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        flash[:notice] = 'Password was successfully changed.'
        format.html { redirect_to(root_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "change_password" }
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.xml
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy

    respond_to do |format|
      format.html { redirect_to(admins_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def auth_change
    if current_admin.blank?
      redirect_to login_path
    end
  end
  
end

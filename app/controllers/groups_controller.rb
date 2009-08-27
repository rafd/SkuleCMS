class GroupsController < ApplicationController
  before_filter :load_club
  before_filter :auth_admin, :only => [:admin, :new, :edit, :create, :update, :destroy, :add_member, :create_membership, :kick]
  def load_club
    @club = Club.find(params[:club_id])
  end
  
  # GET /groups
  # GET /groups.xml
  def index
    @groups = @club.groups
    @grouplist = @club.groups.find(:all, :conditions => ["parent_id IS NOT ?", nil], :order => 'lft')
    
    @page_title = "Group Listing"
    @site_section = "clubs"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end
  
  # GET /groups/admin
  # GET /groups/1/admin
  def admin
    if (params[:id].blank?)
      @groups = @club.groups
      @grouplist = @club.groups.find(:all, :conditions => ["parent_id IS NOT ?", nil], :order => 'lft')
      
      @page_title = "Group Listing"
      @site_section = "admin"
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @groups }
      end
    else
      @group = @club.groups.find(params[:id])
      @page = @club.pages.find(:first, :conditions=> ["title=?",@group.name])
      
      @page_title = "Showing " + @group.name
      @site_section = "admin"
      respond_to do |format|
        format.html { render :action => "admin_show" }
        format.xml  { render :xml => @group }
      end
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = @club.groups.find(params[:id])
    @page = @club.pages.find(:first, :conditions=> ["title=?",@group.name])
    
    @page_title = "Showing " + @group.name
    @site_section = "clubs"
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    @group = @club.groups.new
    @grouplist = @grouplist = @club.groups.find(:all, :conditions => ["parent_id IS NOT ?", nil], :order => 'lft')
    
    @page_title = "New Group"
    @site_section = "admin"
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = @club.groups.find(params[:id])
    @grouplist = @club.groups.find(:all, :conditions => ["parent_id IS NOT ?", nil], :order => 'lft')
    @grouplist -= @group.all_children << @group
    
    @page_title = "Editing " + @group.name
    @site_section = "admin"
  end

  # POST /groups
  # POST /groups.xml
  def create
    @group = @club.groups.new(params[:group])
    respond_to do |format|
      if @group.save
        flash[:notice] = 'Group was successfully created.'
        if (!@group.new_page.blank? && @group.new_page != '0')
          format.html { redirect_to new_club_page_path(@club)}
        else
          format.html { redirect_to admin_club_group_path(@club, @group) }
        end
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        @grouplist = @club.groups.find(:all, :conditions => ["parent_id IS NOT ?", nil], :order => 'lft')
        @page_title = "New Group"
        @site_section = "admin"
        format.html { render :action => "new" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @group = @club.groups.find(params[:id])
    
    respond_to do |format|
      if (@group.is_member_list?)
        flash[:notice] = 'Cannot edit the member list.'
        format.html { redirect_to admin_club_group_path(@club, @group) }
        format.xml  { head :ok }
      elsif @group.update_attributes(params[:group])
        flash[:notice] = 'Group was successfully updated.'
        format.html { redirect_to admin_club_group_path(@club, @group) }
        format.xml  { head :ok }
      else
        @grouplist = @club.groups.find(:all, :conditions => ["parent_id IS NOT ?", nil], :order => 'lft')
        @grouplist -= @group.all_children << @group
        
        @page_title = "Editing " + @group.name
        @site_section = "admin"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    @group = @club.groups.find(params[:id])
    @group.destroy unless @group.is_member_list?

    respond_to do |format|
      format.html { redirect_to(admin_club_groups_url) }
      format.xml  { head :ok }
    end
  end
  
  def add_member
    @user = User.new
    @group = @club.groups.find(params[:id])
    
    @page_title = "Adding New Member to " + @group.name
    @site_section = "admin"
    respond_to do |format|
      format.html
      format.xml  { render :xml => @group }
    end
  end
  
  def create_membership
    @group = @club.groups.find(params[:id])
    @user = User.find(:first, :conditions => {:name => params[:user][:name]})    
    if @user.blank?
      @user = @group.users.new(params[:user])
    else
      @user_already_created = true
    end
    respond_to do |format|
      if @user_already_created || @user.save
        @membership = Membership.new
        @membership.user = @user
        @membership.group = @group
        @membership.save
        flash[:notice] = 'Member was successfully created.'
        format.html { redirect_to admin_club_group_path(@club, @group) }
        format.xml  { render :xml => @membership, :status => :created, :location => @membership }
      else
        @user = User.new
        @page_title = "Adding New Member to " + @group.name
        @site_section = "admin"
        format.html { render :action => "add_member" }
        format.xml  { render :xml => @membership.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def kick
    @membership = Membership.find(params[:member])
    @group = @membership.group
    if @group.is_member_list?
      @memberships = Membership.find(:all, :conditions => {:user_id => @membership.user_id})
      @memberships.each do |member|
        member.destroy
      end
    else
      @membership.destroy
    end
    

    respond_to do |format|
      format.html { redirect_to admin_club_group_path(@club, @group) }
      format.xml  { head :ok }
    end
  end
end

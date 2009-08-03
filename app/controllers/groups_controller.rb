class GroupsController < ApplicationController
  before_filter :load_club
  def load_club
    @club = Club.find(params[:club_id])
  end
  
  # GET /groups
  # GET /groups.xml
  def index
    @groups = @club.groups
    @roots = @club.groups.find(:all, :conditions => {:parent_id => nil})
    puts @club.groups.new().club_id.to_s
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
      @roots = @club.groups.find(:all, :conditions => {:parent_id => nil})
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @groups }
      end
    else
      @group = @club.groups.find(params[:id])
      @page = @club.pages.find(:first, :conditions=> ["title=?",@group.name])
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
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    @group = @club.groups.new
    @grouplist = @club.groups
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @group }
    end
  end

  # GET /groups/1/edit
  def edit
    @group = @club.groups.find(params[:id])
    @grouplist = @club.groups
  end

  # POST /groups
  # POST /groups.xml
  def create
    @group = @club.groups.new(params[:group])
    respond_to do |format|
      if @group.save
        flash[:notice] = 'Group was successfully created.'
        format.html { redirect_to admin_club_group_path(@club, @group) }
        format.xml  { render :xml => @group, :status => :created, :location => @group }
      else
        @grouplist = @club.groups
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
        @grouplist = @club.groups
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
    @groups = @club.groups
    @membership = Membership.new
    @users = User.find(:all)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @group }
    end
  end
  
  def create_membership
    @membership = Membership.new(params[:membership])
    respond_to do |format|
      if @membership.save
        flash[:notice] = 'Membership was successfully created.'
        format.html { redirect_to admin_club_group_path(@club, @membership.group) }
        format.xml  { render :xml => @membership, :status => :created, :location => @membership }
      else
        @groups = @club.groups
        @users = User.find(:all)
        format.html { render :action => "add_member" }
        format.xml  { render :xml => @membership.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def kick
    @membership = Membership.find(params[:member])
    @group = @membership.group
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to admin_club_group_path(@club, @group) }
      format.xml  { head :ok }
    end
  end
end

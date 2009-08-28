require "will_paginate"

class ClubsController < ApplicationController
  before_filter :auth_admin, :only => [:edit, :update]
  before_filter :auth_new_club, :only => [:new, :create]
  before_filter :auth_super_admin_only, :only => [:admin, :destroy]
  
  # GET /clubs
  # GET /clubs.xml
  def index
    @page_title = "Club Directory"
    @site_section = "hub"
    @page_left = "club_tags_list"
    
    @clubs = Club.find(:all, :conditions => ["live=?",true], :include => :tags, :order => "name ASC")
    @tags = Club.find_related_tags("club")   
        
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @clubs }
    end
  end
  
  def admin
    @page_title = "Administrate Clubs"
    @site_section = "su_admin"
    
    @clubs = Club.all
  end

  # GET /clubs/1
  # GET /clubs/1.xml
  def show
    @club = Club.find(params[:id], :include => :tags)
   
    @page_title = ""
    @site_section = "clubs"
    
    @all_posts = @club.feed_output(@club.small_posts.find(:all, :order => "created_at DESC", :limit => 10), @club.large_posts.find(:all, :order => "created_at DESC", :limit => 10))
    @all_posts = @all_posts[0..9]
    
    @feed = @club.feed_output(@club.small_posts.find(:all, :order => "created_at DESC", :limit => 10), @club.large_posts.find(:all, :order => "created_at DESC", :limit => 10),@club.events.find(:all, :order => "created_at DESC", :limit => 10) )
    @feed = @feed[0..2]
    if @feed[0] != nil
      @feed_earliest_time = @feed[-1].created_at
    else
      @feed_earliest_time = 0
    end
    
    # remove:  @feed = @club.feed_items.paginate :page => params[:page], :per_page => 4
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  {} # { render :xml => @club }
    end
  end

  def add_feed_item
    @club = Club.find(params[:id])
    @feed = @club.feed_output(@club.small_posts.find(:all, :conditions => ["created_at < ?", params[:time]], :order => "created_at DESC", :limit => "10"), @club.large_posts.find(:all, :conditions => ["created_at < ?", params[:time]], :order => "created_at DESC", :limit => "10"),@club.events.find(:all, :conditions => ["created_at < ?", params[:time]], :order => "created_at DESC", :limit => "10") )
    @feed = @feed[0..0]

    if @feed[0] != nil
      @feed_earliest_time = @feed[-1].created_at
    else
      @feed_earliest_time = 0
    end
    
    
  end

  # GET /clubs/new
  # GET /clubs/new.xml
  def new
    @new_club = Club.new
    
    @page_title = "New Club"
    @site_section = "admin"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @new_club }
    end
  end

  # GET /clubs/1/edit
  def edit
    @club = Club.find(params[:id], :include => :tags)
    
    @page_title = "Editing "+@club.name
    @site_section = "admin"
  end

  ############################

  # POST /clubs
  # POST /clubs.xml
  def create
    @new_club = Club.new(params[:club])
    
    respond_to do |format|
      if @new_club.save
        current_admin.club_id = @new_club.id
        current_admin.save
        flash[:notice] = 'Club was successfully created.'
        format.html { redirect_to club_admin_index_path(@new_club) }
        format.xml  { render :xml => @new_club, :status => :created, :location => @new_club }
      else
        @page_title = "New Club"
        @site_section = "admin"
        
        format.html { render :action => "new" }
        format.xml  { render :xml => @new_club.errors, :status => :unprocessable_entity }
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
        format.html { redirect_to(club_admin_index_path(@club)) }
        format.xml  { head :ok }
      else
        @page_title = "Editing "+@club.name
        @site_section = "admin"
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
    if current_admin.super_admin
      redirect_to root_url
    elsif current_admin.blank?
      redirect_to login_path
    elsif !current_admin.club_id.blank? && current_admin.club_id.to_s != params[:id]
      redirect_to club_admin_index_path(current_admin.club_id)
    elsif current_admin.club_id.blank?
      redirect_to new_club_path
    end
  end
  
  def auth_new_club
    if current_admin.super_admin
      redirect_to admins_path
    elsif current_admin.blank?
      redirect_to login_path
    elsif !current_admin.club_id.blank?
      redirect_to club_admin_index_path(current_admin.club_id)
    end
  end
end

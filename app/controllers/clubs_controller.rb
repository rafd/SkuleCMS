require "will_paginate"

class ClubsController < ApplicationController
  before_filter :auth_admin, :only => [:edit, :update, :settings, :update_settings]
  before_filter :auth_new_club, :only => [:new, :create]
  before_filter :auth_super_admin_only, :only => [:admin, :destroy, :edit_tags, :update_tags]
  
  # GET /clubs
  # GET /clubs.xml
  def index
    @page_title = "Club Directory"
    @site_section = "hub"
    @page_left = "club_tags_list"
    
    #TODO: only send @clubs that are tagged with club
    @clubs = Club.find(:all, :conditions => ["live=?",true], :include => :tags, :order => "name ASC")
    @tags = Club.find_related_tags("club")   
        
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @clubs }
    end
  end
  
  def go_live
	club = Club.find(params[:club])
	club.update_attribute("live", true)
	render :text => "Live!"
  end
  
  def admin
    @page_title = "Administrate Clubs"
    @site_section = "su_admin"
    
    @live_clubs = Club.find(:all, :conditions => ["live=?" , true], :order => "name ASC")
    @hidden_clubs = Club.find(:all, :conditions => ["live=?" , false], :order => "name ASC")
  end

  # GET /clubs/1
  # GET /clubs/1.xml
  def show
    @club = Club.find(params[:id], :include => :tags)
   
    @page_title = ""
    @site_section = "clubs"
    respond_to do |format|
      format.html {
        @feed = feed_output([@club.small_posts, @club.large_posts, @club.events], feed_list_length, :all, :order => "created_at DESC", :limit => feed_list_length)
        @feed_earliest_time = feed_earliest_time(@feed)
      }
      format.xml {
        @feed = feed_output([@club.small_posts, @club.large_posts, @club.events], feed_rss_length, :all, {:order => "created_at DESC", :limit => feed_rss_length})
        if @feed[0] == nil
          render :xml => @club
        end  
      }  
    end
  end

  def add_feed_item
    @club = Club.find(params[:id])
   
    @feed = feed_output([@club.small_posts, @club.large_posts, @club.events], feed_add_length, :all, { :conditions => ["created_at < ?", params[:time]], :order => "created_at DESC", :limit => feed_add_length})
    @feed_earliest_time = feed_earliest_time(@feed)   
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
    @new_club.live = false
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
  
  
  def edit_tags
    @club = Club.find(params[:club_id], :include => :tags)
    @page_title = "Editing "+@club.name+"'s Tags"
    @site_section = "su_admin"
  end

  def update_tags
    @club = Club.find(params[:club_id], :include => :tags)

    respond_to do |format|
      if @club.update_attribute("tag_list", params[:club][:tag_list])
        flash[:notice] = "Club's tags was successfully updated."
        format.html { redirect_to(club_admin_index_path(@club)) }
        format.xml  { head :ok }
      else
        @page_title = "Editing "+@club.name+"'s Tags"
        @site_section = "su_admin"
        format.html { render :action => "edit_tags" }
        format.xml  { render :xml => @club.errors, :status => :unprocessable_entity }
      end
    end
  end

  def settings
    @club = Club.find(params[:id])
    @page_title = "Changing "+@club.name+"'s Settings"
    @site_section = "admin"
    @pages = @club.all_pages
    @controller_names = ['groups', 'events', 'large_posts', 'albums', 'images', 'download_folders', 'downloads', 'calendar']
    @pageIndex = @club.settings.find(:first, :conditions => ['option_name = ? AND name = ? AND value = ?', 'Banner', 'pages', 'Index'])
    respond_to do |format|
      format.html 
    end       
  end
  
  def update_settings
    @club = Club.find(params[:id])
    @controller_names = ['clubs', 'groups', 'events', 'large_posts', 'albums', 'images', 'download_folders', 'downloads', 'calendar']
    @controller_names.each do |name|
      @club.set_settings(!params[('banner_' + name).to_sym].blank?, 'Banner', name, 'All')
    end
    # Drop previous settings and re-create (easier code-wise)
    @pages = @club.all_pages
    @pages.each do |page|
      @club.set_settings(!params[('banner_pages_'+page.id.to_s).to_sym].blank?, 'Banner', 'pages', page.id.to_s)
    end
    @club.set_settings(!params[('banner_pages_index').to_sym].blank?, 'Banner', 'pages', 'Index')
    respond_to do |format|
      flash[:notice] = "Club's settings were successfully updated."
      format.html { redirect_to(club_admin_index_path(@club)) }
      format.xml  { head :ok }
    end
  end

  private
  
  def auth_admin
    if current_admin.blank?
      redirect_to login_path
    elsif current_admin.super_admin
      redirect_to club_edit_tags_path(params[:id])
    elsif !current_admin.club_id.blank? && current_admin.club_id.to_s != params[:id]
      redirect_to club_admin_index_path(current_admin.club_id)
    elsif current_admin.club_id.blank?
      redirect_to new_club_path
    end
  end
  
  def auth_new_club
    if current_admin.blank?
      redirect_to login_path
    elsif current_admin.super_admin
      redirect_to admins_path
    elsif !current_admin.club_id.blank?
      redirect_to club_admin_index_path(current_admin.club_id)
    end
  end
end

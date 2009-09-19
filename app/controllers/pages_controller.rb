class PagesController < ApplicationController
  before_filter :load_club
  before_filter :auth_admin, :only => [:admin, :new, :edit, :create, :update, :destroy]

       uses_tiny_mce :options => {
                                :theme => 'advanced',
                                :plugins => %w{ advimg media emotions },
                                :theme_advanced_buttons1 => 'bold,italic,underline,strikethrough,|,fontselect,fontsizeselect',
                                :theme_advanced_buttons2 => 'bullist,numlist,|,forecolor,backcolor,|,image,code,|',
                                :theme_advanced_buttons3 => '',
                                :theme_advanced_toolbar_location => 'top',
                                :theme_advanced_toolbar_align => 'left',
                                :theme_advanced_resizing => true,
                                :theme_advanced_statusbar_location => 'bottom',

                              }
  
  # GET /pages
  # GET /pages.xml
  def index
    @pages = @club.all_pages
    
    @page_title = "Page Listing"
    @site_section = "clubs"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end 
  end

  def admin
    if (params[:id].blank?)
      @pages = @club.all_pages
      @page_title = "Page Listing"
      @site_section = "admin"
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @pages }
      end
    else
      @page = @club.pages.find(params[:id])
      @page_title = "Showing "+ @page.title
      @site_section = "admin"
      respond_to do |format|
        format.html { render :action => "admin_show" }
        format.xml  { render :xml => @page }
      end
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = @club.pages.find(params[:id])
    @page_title = @page.title
    @site_section = "clubs"
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new
    @pagelist = @club.all_pages
    
    @page_title = "New Page"
    @site_section = "admin"
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = @club.pages.find(params[:id])
    @pagelist = @club.all_pages
    @pagelist  -= @page.all_children << @page
    
    @page_title = "Editing " + @page.title
    @site_section = "admin"
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = @club.pages.new(params[:page])
    @page.parent_id = params[:page][:parent_id];
    @page.bns_parent_id = params[:page][:parent_id];
    respond_to do |format|
      if @page.save
        flash[:notice] = 'Pages was successfully created.'
	      format.html { redirect_to(admin_club_page_path(@club, @page)) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        @pagelist = @club.all_pages
        
        @page_title = "New Page"
        @site_section = "admin"
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = @club.pages.find(params[:id])
    @page.parent_id = params[:page][:parent_id];
    @page.bns_parent_id = params[:page][:parent_id];
    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Pages was successfully updated.'
        format.html { redirect_to(admin_club_page_path(@club, @page)) }
        format.xml  { head :ok }
      else
        @pagelist = @club.all_pages
        @pagelist = @club.all_pages
        @pagelist  -= @page.all_children << @page
        
        @page_title = "Editing " + @page.title
        @site_section = "admin"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = @club.pages.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(admin_club_pages_url) }
      format.xml  { head :ok }
    end
  end
end

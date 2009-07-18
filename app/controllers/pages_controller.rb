class PagesController < ApplicationController
  before_filter :load_club
  def load_club
    @club = Club.find(params[:club_id])
  end
  
  # GET /pages
  # GET /pages.xml
  def index
    @pages = @club.pages

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end 
  end

  def admin
    if (params[:id].blank?)
      @pages = @club.pages
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @pages }
      end
    else
      @page = Page.find(params[:id])
      respond_to do |format|
        format.html { render :action => "admin_show" }
        format.xml  { render :xml => @page }
      end
    end
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.xml
  def create
    @page = Page.new(params[:page])
		@page.club = @club
    respond_to do |format|
      if @page.save
        flash[:notice] = 'Pages was successfully created.'
	      format.html { redirect_to(admin_club_page_path(@club, @page)) }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.xml
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:notice] = 'Pages was successfully updated.'
        format.html { redirect_to(admin_club_page_path(@club, @page)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to(admin_club_pages_url) }
      format.xml  { head :ok }
    end
  end
end

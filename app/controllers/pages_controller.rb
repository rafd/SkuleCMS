class PagesController < ApplicationController
  before_filter :load_club, :only => [:new, :create, :edit, :index, :show, :destroy]
  def load_club
    @club = Club.find(params[:club_id])
  end
  
  # GET /pages
  # GET /pages.xml
  def index
    @pages = Page.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pages }
    end 
  end

  # GET /pages/1
  # GET /pages/1.xml
  def show
    @pages = Page.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pages }
    end
  end

  # GET /pages/new
  # GET /pages/new.xml
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pages }
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
	      format.html { redirect_to(club_page_url(@club, @page)) }
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
    @pages = Page.find(params[:id])

    respond_to do |format|
      if @pages.update_attributes(params[:pages])
        flash[:notice] = 'Pages was successfully updated.'
        format.html { redirect_to(@pages) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pages.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.xml
  def destroy
    @pages = Page.find(params[:id])
    @pages.destroy

    respond_to do |format|
      format.html { redirect_to(club_pages_path(@club)) }
      format.xml  { head :ok }
    end
  end
end

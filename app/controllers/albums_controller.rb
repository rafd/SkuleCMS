class AlbumsController < ApplicationController
  before_filter :load_club
  def load_club
    @club = Club.find(params[:club_id])
  end
  
  # GET /albums
  # GET /albums.xml
  def index
    @albums = @club.albums
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @albums }
    end
  end

  def admin
    if (params[:id].blank?)
      @albums = @club.albums
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @albums }
      end
    else
      @album = Album.find(params[:id], :include => :tags)
  
      respond_to do |format|
        format.html { render :action => "admin_show" }
        format.xml  { render :xml => @album }
      end
    end
  end

  # GET /albums/1
  # GET /albums/1.xml
  def show
    @album = Album.find(params[:id], :include => :tags)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/new
  # GET /albums/new.xml
  def new
    @album = Album.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @album }
    end
  end

  # GET /albums/1/edit
  def edit
    @album = Album.find(params[:id])
  end

  # POST /albums
  # POST /albums.xml
  def create
    @album = Album.new(params[:album])
    @album.club = @club
    respond_to do |format|
      if @album.save
        flash[:notice] = 'Album was successfully created.'
        format.html { redirect_to admin_club_album_url(@club, @album) }
        format.xml  { render :xml => @album, :status => :created, :location => @album }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /albums/1
  # PUT /albums/1.xml
  def update
    @album = Album.find(params[:id])

    respond_to do |format|
      if @album.update_attributes(params[:album])
        flash[:notice] = 'Album was successfully updated.'
        format.html { redirect_to admin_club_album_url(@club, @album) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @album.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.xml
  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to(admin_club_gallery_path(@club)) }
      format.xml  { head :ok }
    end
  end
end

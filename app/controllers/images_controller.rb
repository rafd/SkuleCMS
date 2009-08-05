class ImagesController < ApplicationController
  before_filter :load_album
  def load_album
    @album = Album.find(params[:album_id], :include => :tags)
  end

  
  
  # GET /images
  # GET /images.xml
  def index
    @tags = Tag.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    #Category.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    @images = Image.all

 #   respond_to do |format|
 #    format.html # index.html.erb
 #     format.xml  { render :xml => @images }
 #   end
  end

  # GET /images/1
  # GET /images/1.xml
  def show
    @image = Image.find(params[:id], :include => :tags)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/new
  # GET /images/new.xml
  def new
    @image = Image.new
    @user = User.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/1/edit
  def edit
    @image = @album.images.find(params[:id])
  end

  # POST /images
  # POST /images.xml
  def create 
    @image = @album.images.new(params[:image])
    @image.url = Image.save(params[:image][:url], @album)

    respond_to do |format|
      if @image.save
        flash[:notice] = 'Image was successfully uploaded to album.'
        format.html { redirect_to(club_album_image_path(@image.album.club, @image.album, @image)) }
        format.xml  { render :xml => @image, :status => :created, :location => @image }
      else
        @user = User.find(:all)
        format.html { render :action => "new" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /images/1
  # PUT /images/1.xml
  def update
    @image = @album.images.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        flash[:notice] = 'Image was successfully updated.'
        format.html { redirect_to(@image) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.xml
  def destroy
    @image = @album.images.find(params[:id])
    @album = @image.album
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(admin_club_album_path(@album.club, @album)) }
      format.xml  { head :ok }
    end
  end
end

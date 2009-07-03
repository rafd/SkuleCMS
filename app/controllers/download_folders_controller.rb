class DownloadFoldersController < ApplicationController
  # GET /download_folders
  # GET /download_folders.xml
  def index
    @download_folders = DownloadFolder.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @download_folders }
    end
  end

  # GET /download_folders/1
  # GET /download_folders/1.xml
  def show
    @download_folder = DownloadFolder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @download_folder }
    end
  end

  # GET /download_folders/new
  # GET /download_folders/new.xml
  def new
    @download_folder = DownloadFolder.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @download_folder }
    end
  end

  # GET /download_folders/1/edit
  def edit
    @download_folder = DownloadFolder.find(params[:id])
  end

  # POST /download_folders
  # POST /download_folders.xml
  def create
    @download_folder = DownloadFolder.new(params[:download_folder])

    respond_to do |format|
      if @download_folder.save
        flash[:notice] = 'DownloadFolder was successfully created.'
        format.html { redirect_to(@download_folder) }
        format.xml  { render :xml => @download_folder, :status => :created, :location => @download_folder }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @download_folder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /download_folders/1
  # PUT /download_folders/1.xml
  def update
    @download_folder = DownloadFolder.find(params[:id])

    respond_to do |format|
      if @download_folder.update_attributes(params[:download_folder])
        flash[:notice] = 'DownloadFolder was successfully updated.'
        format.html { redirect_to(@download_folder) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @download_folder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /download_folders/1
  # DELETE /download_folders/1.xml
  def destroy
    @download_folder = DownloadFolder.find(params[:id])
    @download_folder.destroy

    respond_to do |format|
      format.html { redirect_to(download_folders_url) }
      format.xml  { head :ok }
    end
  end
end

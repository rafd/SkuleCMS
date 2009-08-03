class DownloadsController < ApplicationController
  before_filter :load_download_folder
  def load_download_folder
    @download_folder = DownloadFolder.find(params[:file_id])
  end
  # GET /downloads
  # GET /downloads.xml
  def index
    @downloads = @download_folder.downloads

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @downloads }
    end
  end
  
  # GET /downloads/1
  # GET /downloads/1.xml
  def show
    @download = @download_folder.downloads.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @download }
    end
  end

  # GET /downloads/new
  # GET /downloads/new.xml
  def new
    @download = Download.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @download }
    end
  end

  # GET /downloads/1/edit
  def edit
    @download = @download_folder.downloads.find(params[:id])
  end

  # POST /downloads
  # POST /downloads.xml
  def create
    @download = @download_folder.downloads.new(params[:download])
    @download.url = Download.save(params[:download][:url])
    respond_to do |format|
      if @download.save
        flash[:notice] = 'File was successfully uploaded.'
        format.html { redirect_to(admin_club_file_path(@download.download_folder.club, @download.download_folder)) }
        format.xml  { render :xml => @download, :status => :created, :location => @download }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @download.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /downloads/1
  # PUT /downloads/1.xml
  def update
    @download = @download_folder.downloads.find(params[:id])

    respond_to do |format|
      if @download.update_attributes(params[:download])
        flash[:notice] = 'Download was successfully updated.'
        format.html { redirect_to(admin_club_file_path(@download.download_folder.club, @download.download_folder)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @download.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /downloads/1
  # DELETE /downloads/1.xml
  def destroy
    @download = @download_folder.downloads.find(params[:id])
    @download_folder = @download.download_folder
    @download.destroy

    respond_to do |format|
      format.html { redirect_to(admin_club_file_path(@download_folder.club, @download_folder)) }
      format.xml  { head :ok }
    end
  end
end

class Admin::FilesController < ApplicationController
  before_filter :load_club
  def load_club
    @club = Club.find(params[:club_id])
  end

  
  # GET /admins/files
  def index
    @download_folders = @club.download_folders

    respond_to do |format|
      format.html # downloads.html.erb
      format.xml  { render :xml => @download_folders  }
    end
  end
  
  def file_edit
    begin
      @download = Download.find(params[:download])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid download #{params[:download]}" )
      redirect_to_index("Invalid Download" )
    else
      respond_to { |format| format.js }
    end
  end  
  
  def file_new
    begin
      @download_folder = DownloadFolder.find(params[:folder])
      @download = Download.new
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid folder #{params[:folder]}" )
      redirect_to_index("Invalid Folder" )
    else
      respond_to { |format| format.js }
    end
  end
  
  def file_create   
    begin
      @download = Download.new(params[:download])
      @download_folder = DownloadFolder.find(params[:folder])
      @download.url = Download.save(params[:download][:url])
      @download.download_folder = @download_folder
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid folder #{params[:folder]}" )
      redirect_to_index("Invalid Folder" )
    else
      if @download.save
        flash[:notice] = 'File was successfully created.'
        respond_to { |format| format.js }
      else
        respond_to { |format| format.js {render :action => "file_new"}}
      end
    end
  end
  
  def file_update
    begin
      @download = Download.find(params[:file])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid download #{params[:file]}" )
      redirect_to_index("Invalid Folder" )
    else
      if @download.update_attributes(params[:download])
        flash[:notice] = 'Download was successfully updated.'
        respond_to { |format| format.js }
      else
        respond_to { |format| format.js {render :action => "file_edit"}}
      end
    end
  end
  
  def file_destroy
    begin
      @download = Download.find(params[:download])
      @file_num = @download.id
      @download.destroy
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to delete invalid file #{params[:download]}" )
      redirect_to_index("Invalid File" )
    else
      respond_to { |format| format.js }
    end
  end
  
  def show_files
    begin
      @download_folder = DownloadFolder.find(params[:folder])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid folder #{params[:folder]}" )
      redirect_to_index("Invalid Folder" )
    else
      respond_to { |format| format.js }
    end
  end
  
  def hide_files
    begin
      @download_folder = DownloadFolder.find(params[:folder])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid folder #{params[:folder]}" )
      redirect_to_index("Invalid Folder" )
    else
      respond_to { |format| format.js }
    end
  end
  
  def folder_edit
    begin
      @download_folder = DownloadFolder.find(params[:folder])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid folder #{params[:folder]}" )
      redirect_to_index("Invalid Folder" )
    else
      respond_to { |format| format.js }
    end
  end
  
  def folder_update
    begin
      @download_folder = DownloadFolder.find(params[:folder])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid folder #{params[:folder]}" )
      redirect_to_index("Invalid Folder" )
    else
      if @download_folder.update_attributes(params[:download_folder])
        flash[:notice] = 'DownloadFolder was successfully updated.'
        respond_to { |format| format.js }
      else
        respond_to { |format| format.js {render :action => "folder_edit"}}
      end
    end
  end
  
  def folder_new
    @download_folder = DownloadFolder.new
    respond_to { |format| format.js }
  end
  
  def folder_create    
    @download_folder = DownloadFolder.new(params[:download_folder])
    @download_folder.club_id = @club.id    
    if @download_folder.save
      flash[:notice] = 'DownloadFolder was successfully created.'
      respond_to { |format| format.js }
    else
      respond_to { |format| format.js {render :action => "folder_new"}}
    end
  end
  
  def folder_destroy
    begin
      @download_folder = DownloadFolder.find(params[:folder])
      @folder_num = @download_folder.id
      @download_folder.downloads.each do |download|
        download.destroy
      end
      @download_folder.destroy
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to delete invalid folder #{params[:folder]}" )
      redirect_to_index("Invalid Folder" )
    else
      respond_to { |format| format.js }
    end
  end
end
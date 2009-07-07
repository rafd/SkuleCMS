class AdminsController < ApplicationController
  before_filter :load_club, :except => [:index, :show, :new, :update, :create, :edit, :destroy]
  def load_club
    @club = Club.find(params[:club_id])
  end
  
  # GET /admins
  # GET /admins.xml
  def index
    @admins = Admin.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admins }
    end
  end

  # GET /admins/1
  # GET /admins/1.xml
  def show
    @admin = Admin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin }
    end
  end

  # GET /admins/new
  # GET /admins/new.xml
  def new
    @admin = Admin.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin }
    end
  end

  # GET /admins/1/edit
  def edit
    @admin = Admin.find(params[:id])
  end

  # POST /admins
  # POST /admins.xml
  def create
    @admin = Admin.new(params[:admin])

    respond_to do |format|
      if @admin.save
        flash[:notice] = 'Admin was successfully created.'
        format.html { redirect_to(@admin) }
        format.xml  { render :xml => @admin, :status => :created, :location => @admin }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admins/1
  # PUT /admins/1.xml
  def update
    @admin = Admin.find(params[:id])

    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        flash[:notice] = 'Admin was successfully updated.'
        format.html { redirect_to(@admin) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /admins/files
  def files
    @download_folders = @club.download_folders

    respond_to do |format|
      format.html # downloads.html.erb
      format.xml  { render :xml => @download_folders  }
    end
  end
  
  def show_files
    puts params[:folder]
    begin
      @download_folder = DownloadFolder.find(params[:folder])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid folder #{params[:folder]}" )
      redirect_to_index("Invalid product" )
    else
      respond_to { |format| format.js }
    end
  end
  
  def hide_files
    puts params[:folder]
    begin
      @download_folder = DownloadFolder.find(params[:folder])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid folder #{params[:folder]}" )
      redirect_to_index("Invalid product" )
    else
      respond_to { |format| format.js }
    end
  end
  # DELETE /admins/1
  # DELETE /admins/1.xml
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy

    respond_to do |format|
      format.html { redirect_to(admins_url) }
      format.xml  { head :ok }
    end
  end
  
  
end

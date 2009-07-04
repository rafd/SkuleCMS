class GroupsController < ApplicationController
  # GET /groups
  # GET /groups.xml
  def index
    @groups = Groups.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  # GET /groups/1
  # GET /groups/1.xml
  def show
    @groups = Groups.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  # GET /groups/new
  # GET /groups/new.xml
  def new
    @groups = Groups.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @groups }
    end
  end

  # GET /groups/1/edit
  def edit
    @groups = Groups.find(params[:id])
  end

  # POST /groups
  # POST /groups.xml
  def create
    @groups = Groups.new(params[:groups])

    respond_to do |format|
      if @groups.save
        flash[:notice] = 'Groups was successfully created.'
        format.html { redirect_to(@groups) }
        format.xml  { render :xml => @groups, :status => :created, :location => @groups }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @groups.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /groups/1
  # PUT /groups/1.xml
  def update
    @groups = Groups.find(params[:id])

    respond_to do |format|
      if @groups.update_attributes(params[:groups])
        flash[:notice] = 'Groups was successfully updated.'
        format.html { redirect_to(@groups) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @groups.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.xml
  def destroy
    @groups = Groups.find(params[:id])
    @groups.destroy

    respond_to do |format|
      format.html { redirect_to(groups_url) }
      format.xml  { head :ok }
    end
  end
end

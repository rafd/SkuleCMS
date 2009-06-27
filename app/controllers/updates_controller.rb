class UpdatesController < ApplicationController
  # GET /updates
  # GET /updates.xml
  def index
    @updates = Updates.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @updates }
    end
  end

  # GET /updates/1
  # GET /updates/1.xml
  def show
    @updates = Updates.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @updates }
    end
  end

  # GET /updates/new
  # GET /updates/new.xml
  def new
    @updates = Updates.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @updates }
    end
  end

  # GET /updates/1/edit
  def edit
    @updates = Updates.find(params[:id])
  end

  # POST /updates
  # POST /updates.xml
  def create
    @updates = Updates.new(params[:updates])

    respond_to do |format|
      if @updates.save
        flash[:notice] = 'Updates was successfully created.'
        format.html { redirect_to(@updates) }
        format.xml  { render :xml => @updates, :status => :created, :location => @updates }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @updates.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /updates/1
  # PUT /updates/1.xml
  def update
    @updates = Updates.find(params[:id])

    respond_to do |format|
      if @updates.update_attributes(params[:updates])
        flash[:notice] = 'Updates was successfully updated.'
        format.html { redirect_to(@updates) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @updates.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /updates/1
  # DELETE /updates/1.xml
  def destroy
    @updates = Updates.find(params[:id])
    @updates.destroy

    respond_to do |format|
      format.html { redirect_to(updates_url) }
      format.xml  { head :ok }
    end
  end
end

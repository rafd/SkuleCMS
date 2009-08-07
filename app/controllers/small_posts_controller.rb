class SmallPostsController < ApplicationController
  before_filter :load_club
  before_filter :auth_admin, :only => [:admin, :new, :edit, :create, :update, :destroy]
  def load_club
    @club = Club.find(params[:club_id])
  end

  # GET /small_posts
  # GET /small_posts.xml
  def index
    @small_posts = @club.small_posts.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml {} #{ render :xml => @small_posts }
    end
  end

  def admin
       if (params[:id].blank?)
         @small_posts = @club.small_posts.all
         respond_to do |format|
          format.html #admin.html.erb
          format.xml { render :xml => @small_posts }
         end
       else
           @small_post = @club.small_posts.find(params[:id])
           
         respond_to do |format|
          format.html { render :action => "admin_show" }
          format.xml  { render :xml => @small_post }
        end  
      end
  end

  # GET /small_posts/1
  # GET /small_posts/1.xml
  def show
    @small_post = @club.small_posts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @small_post }
    end
  end

  # GET /small_posts/new
  # GET /small_posts/new.xml
  def new
    @small_post = @club.small_posts.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @small_post }
    end
  end


  # GET /small_posts/1/edit
  def edit
    @small_post = @club.small_posts.find(params[:id])
  end

  # POST /small_posts
  # POST /small_posts.xml
  def create
    @small_post = @club.small_posts.new(params[:small_post])

    respond_to do |format|
      if params[:commit] == "Try a Twat"
        #redirect
        format.html { redirect_to :controller => "large_posts", :action => "new", :content => params[:small_post][:content] }
      else
        #save normally as a twit
        if @small_post.save
          flash[:notice] = 'SmallPost was successfully created.'
          format.html { redirect_to admin_club_small_post_path(@club, @small_post) }
          format.xml  { render :xml => @small_post, :status => :created, :location => @small_post }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @small_post.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /small_posts/1
  # PUT /small_posts/1.xml
  def update
    @small_post = @club.small_posts.find(params[:id])

    respond_to do |format|
      if @small_post.update_attributes(params[:small_post])
        flash[:notice] = 'SmallPost was successfully updated.'
        format.html { redirect_to(@small_post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @small_post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /small_posts/1
  # DELETE /small_posts/1.xml
  def destroy
    @small_post = @club.small_posts.find(params[:id])
    @small_post.destroy

    respond_to do |format|
      format.html { redirect_to(admin_club_small_posts_url) }
      format.xml  { head :ok }
    end
  end
end

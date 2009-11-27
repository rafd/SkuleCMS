class HubPagesController < ApplicationController
  caches_page :index, :services, :calendar
  
  def index
		@page_banner = true
		@site_section = "hub"
	end

  def digest
    @page_title = "The Digest"
    @site_section = "hub"
    @upcoming_events = Event.find(:all, :order => "start", :conditions => ["finish>=?", Time.now.utc], :limit => 10)
    #feed_pull_external(559393962)
    #feed_pull_external(770534509)
    
    
    feed_club_list = Club.find(:all, :conditions => "rss_link IS NOT NULL")
    
    feed_club_list.each do |feed_club|
      feed_pull_external(feed_club)
    end
      
    
    respond_to do |format|
      format.html {
        @feed = feed_output([ExternalPost, LargePost, SmallPost, Event], feed_list_length,:all,{:order => "created_at DESC", :limit => feed_list_length})
        @feed_earliest_time = feed_earliest_time(@feed)
      }
      format.xml  {
        @feed = feed_output([LargePost, SmallPost, Event], feed_rss_length,:all,{:order => "created_at DESC", :limit => feed_rss_length})
      }
    end
  end
  
  def add_feed_item
    @feed = feed_output([ExternalPost, LargePost, SmallPost, Event], feed_add_length, :all, { :conditions => ["created_at < ?", params[:time]], :order => "created_at DESC", :limit => feed_add_length})
    @feed_earliest_time = feed_earliest_time(@feed)
  end

  def calendar
  	@page_title = "Calendar"
  	@site_section = "hub"

    @calendars = Club.find(:all, :conditions => ['gcal IS NOT ? AND gcal != ? AND live = ?', nil, '', true], :select => 'name, gcal')
  end

	#see clubs/index

	def map
		@page_title = "Map"
		@site_section = "hub"
	end

	def services
		@page_title = "Services"
		@site_section = "hub"
		@page_left = "club_tags_list"
   
   		#should use find_tagged_with('engsoc') but this doesn't work 
		@clubs = Club.find(:all, :conditions => ["live=?",true], :include => :tags, :order => "name ASC")   
		@tags = Club.find_related_tags("engsoc")
    end
end

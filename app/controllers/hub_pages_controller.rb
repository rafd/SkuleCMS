class HubPagesController < ApplicationController
	def index
		@page_banner = true
		@site_section = "hub"
	end

  def digest
    @page_title = "The Digest"
    @site_section = "hub"
    @upcoming_events = Event.find(:all, :order => "start", :conditions => ["finish>=?", Time.now.utc], :limit => 10)

    respond_to do |format|
      format.html {
        @feed = feed_output([LargePost, SmallPost, Event], feed_list_length,:all,{:order => "created_at DESC", :limit => feed_list_length})
        @feed_earliest_time = feed_earliest_time(@feed)
      }
      format.xml  {
        @feed = feed_output([LargePost, SmallPost, Event], feed_rss_length,:all,{:order => "created_at DESC", :limit => feed_rss_length})
      }
    end
  end
  
  def add_feed_item
    @feed = feed_output([LargePost, SmallPost, Event], feed_add_length, :all, { :conditions => ["created_at < ?", params[:time]], :order => "created_at DESC", :limit => feed_add_length})
    @feed_earliest_time = feed_earliest_time(@feed)
  end

	#see calendar/index

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

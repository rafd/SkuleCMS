class HubPagesController < ApplicationController
	def index
		@page_banner = true
		@site_section = "hub"
	end

	def digest
		@page_title = "The Digest"
		
		@feed_items = LargePost.all + SmallPost.all + Event.all
		@upcoming_events = Event.find(:all, :order => "start", :conditions => ["finish>=?", Time.now.utc], :limit => 10)
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
	end

end

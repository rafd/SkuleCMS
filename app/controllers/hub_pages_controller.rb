class HubPagesController < ApplicationController
	def index
		@page_title = "Skule.ca"
		@page_banner = true
	end

	def digest
		@page_title = "The Digest"
		
		@feed_items = LargePost.all + SmallPost.all + Event.all
		@upcoming_events = Event.find(:all, :order => "start", :conditions => ["finish>=?", Time.now.utc], :limit => 10)
	end

	def calendar
		@page_title = "SkuleCalendar"
	end

	def clubs
		@page_title = "SkuleClubs"
	end

	def map
		@page_title = "SkuleMap"
	end

	def services
		@page_title = "Services"
	end

end

class HubPagesController < ApplicationController
	def index
		@page_title = "Skule.ca"
		@page_description = "Welcome!"
	end

	def about
		@page_title = "About"
		@page_description = "Short about blurb."
	end

	def digest
		@page_title = "The Digest"
		@page_description = "Check out the latest happenings."
		
		@feed_items = LargePost.all + SmallPost.all
	end

	def calendar
		@page_title = "SkuleCalendar"
		@page_description = "Upcoming events."
	end

	def clubs
		@page_title = "SkuleClubs"
		@page_description = "Lots of clubs at skule. Yep yep."
	end

	def map
		@page_title = "SkuleMap"
		@page_description = "Where is x?"
	end

	def services
		@page_title = "Services"
		@page_description = "Do you have the time? Depends. Do you have the money?"
	end

end

class CalendarController < ApplicationController
  
  def index
    @page_title = "Calendar"
    @site_section = "hub"
  
    @month = params[:month].to_i
    @year = params[:year].to_i

    @shown_month = Date.civil(@year, @month)

    @event_strips = Event.event_strips_for_month(@shown_month)
  end

end

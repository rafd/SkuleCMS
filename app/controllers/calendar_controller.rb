class CalendarController < ApplicationController
  def index
    @page_title = "Calendar"
    @site_section = "clubs"
    @disable_widgets = true
    
    redirect_to club_path(@club) if @club.gcal.blank?
  end
end

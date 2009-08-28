module CalendarHelper
    def month_link(month_date)
      link_to(month_date.strftime("%B"), {:month => month_date.month, :year => month_date.year})
    end
  
    # custom options for this calendar
    def event_calendar_options
      { 
        :year => @year,
        :month => @month,
        :event_strips => @event_strips,
        :month_name_text => @shown_month.strftime("%B %Y"),
        :previous_month_text => "<< " + month_link(@shown_month.last_month),
        :next_month_text => month_link(@shown_month.next_month) + " >>",
        :event_width => 75
      }
    end

    def event_calendar
      calendar event_calendar_options do |event|
        if event.link.blank?
          link_to("<div>" + event.name + " - " + event.club.name + "</div>", {:controller => 'events', :action => 'show', :club_id => event.club_id, :id => event.id}, :title => event.name + " - " + event.club.name)
        else
          link_to("<div>" + event.name + " - " + event.club.name + "</div>", event.link, :title => event.name + " - " + event.club.name)        
        end
      end
    end

end

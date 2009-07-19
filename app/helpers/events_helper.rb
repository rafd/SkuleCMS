module EventsHelper
  def format_time(time)
    return time.strftime('%A %B %d %I:%M %p')
  end
end

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def currentpage(*args)
	arg1 = args[0][0]
	arg2 = args[0][1]
	if args.size == 1
		return ((controller.controller_name==arg1) && (controller.action_name==arg2))
	end
	return ((controller.controller_name==arg1) && (controller.action_name==arg2)) || currentpage(args - [[args[0]],[args[1]]])
  end
  
  def abbrev(string, maxlength)
  	if string.length > maxlength
  		return "<span title='#{string}'>"+string[0..(maxlength-2)] + "..."
  	else
  		return string
  	end
  end
  
  def summarize(string, maxlength, name, options = {}, html_options = {})

  	if string.length > maxlength
  		return string[0..maxlength] + "..." + link_to(name, options, html_options)
	else
		return string
	end 
  end

  def format_time(time)
    #return time.strftime('%a. %b. %e %l:%M %p')
    return time.strftime('%a. %b. %d %I:%M %p')
  end
  
  def short_time(time)
    #return time.strftime('%b. %e, %l:%M %p')
    return time.strftime('%b. %d, %I:%M %p')
  end
  
  def truncate_string(text, length = 30, truncate_string = "...")
    return if text.nil?
    l = length - truncate_string.chars.length
    text.chars.length > length ? text[/\A.{#{l}}\w*\;?/m][/.*[\w\;]/m] + truncate_string : text
  end
  
  def display_all_tags_classes(club)
    @tagline = ''
    club.tags.each { |tag| @tagline += ' TAG_' + tag.name }
    return @tagline
  end
  
  def display_multi_line_string(text)
    return text.gsub("\n", "<br />")
  end
  
end

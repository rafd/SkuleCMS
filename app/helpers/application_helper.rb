# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

=begin
	def render__partial(input)
		
		if FileTest.exist?(File.join(RAILS_ROOT, 'app', 'views', controller.controller_name,'_'+input+'.html.erb'))
			render :partial => input 
		else
			render :partial => ('layouts/'+input)
		end

	end
=end

	def render__partial(element)
		
		if controller.controller_name == 'hub_pages' || (controller.controller_name == "clubs" && controller.action_name == "index")|| controller.controller_name == 'users' 
			render_this_or_default('hub', element)
		elsif controller.controller_name != "admin_pages" and (controller.action_name == "show" || controller.action_name == "index")
			render_this_or_default('clubs', element)
		else
			render_this_or_default('admin', element)
		end
	
	end
	
	def render_this_or_default(folder, element)
		if FileTest.exist?(File.join(RAILS_ROOT, 'app', 'views', 'layouts', folder, '_'+element+'.html.erb'))
			render :partial => ('layouts/'+folder+'/'+element) 
		else
			render :partial => ('layouts/default/'+element)
		end
  end

  def format_time(time)
    return time.strftime('%a. %b. %d %I:%M %p')
  end
  
  def truncate_string(text, length = 30, truncate_string = "...")
    return if text.nil?
    l = length - truncate_string.chars.length
    text.chars.length > length ? text[/\A.{#{l}}\w*\;?/m][/.*[\w\;]/m] + truncate_string : text
  end

end

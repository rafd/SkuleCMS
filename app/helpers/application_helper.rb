# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def test (p1, p2)
    render clubs_path
  end

  def render__partial(*args)
    @element = args[0]
		if (args.length==1)
      if controller.controller_name == 'hub_pages' || (controller.controller_name == "clubs" && controller.action_name == "index")|| controller.controller_name == 'users' || controller.controller_name == 'calendar' || (controller.controller_name == 'admins' && (controller.action_name != 'change_password' || controller.action_name != 'update_password' )) 
        render_this_or_default('hub', @element)
      elsif controller.controller_name != "admin_pages" and (controller.action_name == "show" || controller.action_name == "index")
        render_this_or_default('clubs', @element)
      else
        render_this_or_default('admin', @element)
      end
      
    else
      @club_id = args[1]

      if controller.controller_name == 'hub_pages' || (controller.controller_name == "clubs" && controller.action_name == "index")|| controller.controller_name == 'users' 
        render_this_or_default('hub', @element, @club_id)
      elsif controller.controller_name != "admin_pages" and (controller.action_name == "show" || controller.action_name == "index")
        render_this_or_default('clubs', @element, @club_id)
      else
        render_this_or_default('admin', @element, @club_id)
      end
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

  def render_this_or_default(*args)
    @folder = args[0]
    @element = args[1]
    
    if args.length == 3
      @club_id = args[2]
      
      if FileTest.exist?(File.join(RAILS_ROOT, 'app', 'views', 'layouts', @folder, '_'+@element+'.html.erb')) || FileTest.exist?(File.join(RAILS_ROOT, 'app', 'views', 'layouts', @folder, '_'+@element+'.html.haml'))
        render :partial => ('layouts/'+@folder+'/'+@element), :locals => { :club_id => @club_id }
      else
        render :partial => ('layouts/default/'+@element), :locals => { :club_id => @club_id }
      end
    else
      if FileTest.exist?(File.join(RAILS_ROOT, 'app', 'views', 'layouts', @folder, '_'+@element+'.html.erb')) || FileTest.exist?(File.join(RAILS_ROOT, 'app', 'views', 'layouts', @folder, '_'+@element+'.html.haml'))
        render :partial => ('layouts/'+@folder+'/'+@element) 
      else
        render :partial => ('layouts/default/'+@element)
      end
    end
  end
  
  def display_multi_line_string(text)
    return text.gsub("\n", "<br />")
  end
  
end

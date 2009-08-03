# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def test (p1, p2)
    render clubs_path
  end


	def render__partial(*args)
    @element = args[0]
		if (args.length==1)
      if controller.controller_name == 'hub_pages' || (controller.controller_name == "clubs" && controller.action_name == "index")|| controller.controller_name == 'users' 
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
	
	def render_this_or_default(*args)
    @folder = args[0]
    @element = args[1]
    
    if args.length == 3
      @club_id = args[2]
      
		  if FileTest.exist?(File.join(RAILS_ROOT, 'app', 'views', 'layouts', @folder, '_'+@element+'.html.erb'))
			  render :partial => ('layouts/'+@folder+'/'+@element), :locals => { :club_id => @club_id }
		  else
			  render :partial => ('layouts/default/'+@element), :locals => { :club_id => @club_id }
			end
	  else
      if FileTest.exist?(File.join(RAILS_ROOT, 'app', 'views', 'layouts', @folder, '_'+@element+'.html.erb'))
        render :partial => ('layouts/'+@folder+'/'+@element) 
      else
        render :partial => ('layouts/default/'+@element)
      end
    end
	end
end

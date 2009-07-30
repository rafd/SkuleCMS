# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def render__partial(input, club_id={})
		
		if FileTest.exist?(File.join(RAILS_ROOT, 'app', 'views', controller.controller_name,'_'+input+'.html.erb'))
			render :partial => input
		else
			render :partial => ('layouts/'+input), :locals => { :club_id => club_id }
		end

	end


end

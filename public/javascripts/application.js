// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

document.observe('dom:loaded', function() {
	var numActive = 0;
	var tags = new Array (10);
	var effectDuration = 0.2;
	$$('a.taglist').each(function(elmt) {
		elmt.observe('click', function (event){
			var element = event.element();
			var tag = $w(element.className).find(function(value){
				return value.substring(0,9) == "LEFT_TAG_";
			});
			tag = tag.substring(5);
			if (!element.hasClassName('selected'))
			{
				if (numActive ==0)
				{
						element.toggleClassName('selected');
						$('clubs_container').immediateDescendants().each(function(club){
							if (!club.hasClassName(tag)){
								//club.fade({ duration: effectDuration , queue: { position: 'end', scope: tag } });
								new Effect.Fade(club, { duration: effectDuration , queue: { position: 'end', scope: tag } });
								}
						});
						for (var x = 0; x<10; x++)
						{
							if (tags[x]== null)
							{
								tags[x] = tag;
								break;
							}	
						}
						numActive ++;
				}
				else if (numActive < 10)
				{
						element.toggleClassName('selected');
						$('clubs_container').immediateDescendants().each(function(club){
							if (club.hasClassName(tag)){
								//club.appear({ duration: effectDuration , queue: { position: 'end', scope: tag } });
								new Effect.Appear(club, { duration: effectDuration , queue: { position: 'end', scope: tag } });
							}	
						});
						for (var x = 0; x<10; x++)
						{
							if (tags[x]== null)
							{
								tags[x] = tag;
								break;
							}	
						}
						numActive ++;
				}
				else
				{
						//Do nothing
				}
			}
			else
			{
				element.toggleClassName('selected');
				for (var x = 0; x<10; x++)
				{
					if (tags[x]== tag)
					{
						tags[x] = null;
						break;
					}	
				}
				if (numActive ==1)
				{
						$('clubs_container').immediateDescendants().each(function(club){
								//club.appear({ duration: effectDuration , queue: { position: 'end', scope: tag } });
								new Effect.Appear(club, { duration: effectDuration , queue: { position: 'end', scope: tag } });
						});
				}
				else
				{
						$('clubs_container').immediateDescendants().each(function(club){
							if (club.hasClassName(tag))
							{
								var check = false;
								for (var x = 0; x<10; x++)
								{
									if (tags[x] != null && club.hasClassName(tags[x]))
									{
										check = true;
										break;
									}	
								}
								if (!check)
								{
									//club.fade({ duration: effectDuration , queue: { position: 'end', scope: tag } });
									new Effect.Fade(club, { duration: effectDuration , queue: { position: 'end', scope: tag } });
								}	
							}
						});
				}
				numActive --;	
			}
		});
	});
});

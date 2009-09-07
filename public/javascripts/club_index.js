document.observe('dom:loaded', function() {
	var selectedTags = [];
	
	var clubs = $$('#content .clubs_container')[0];
	
	
	$$('a.taglist').each(function(elmt) {
		elmt.observe('click', function (event){
			var tag = $w(elmt.className).find(function(value){
				return value.substring(0,9) == "LEFT_TAG_";
			});
			var tag = tag.substring(5);
			
			elmt.toggleClassName('selected');
			
			if(elmt.hasClassName('selected')){
				selectedTags.push(tag);
				//TODO: test if including .visible makes it faster or slower
				clubs.select('div.club.visible:not(.'+tag+')').each(function(club){ //only visible clubs
					club.removeClassName('visible');
					club.addClassName('hidden');
				});
			} else { 
				selectedTags = selectedTags.without(tag);
				clubs.select('div.club.hidden').each(function(club){ //only hidden clubs
					var show = true;
					selectedTags.each(function(tagg){
						if(!club.hasClassName(tagg)){
							show = false;
						}
					});
					if(show){
						club.removeClassName('hidden');
						club.addClassName('visible');
					}
				});
			}
			
		});
	});	
});
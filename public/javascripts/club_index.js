document.observe('dom:loaded', function() {
	var prev = null;
	var clubs = $$('#content .clubs_container')[0];
	$$('a.taglist').each(function(elmt) {
		elmt.observe('click', function (event){
			var tag = $w(elmt.className).find(function(value){
				return value.substring(0,9) == "LEFT_TAG_";
			});
			if (prev != null && prev != tag)
				$$('a.taglist.'+prev)[0].toggleClassName('selected');
			prev = tag;
			var tag = tag.substring(5);
			elmt.toggleClassName('selected');
			if(elmt.hasClassName('selected')){
				//TODO: test if including .visible makes it faster or slower
				clubs.select('div.club.visible:not(.'+tag+')').each(function(club){ //only visible clubs
					club.removeClassName('visible');
					club.addClassName('hidden');
				});
				clubs.select('div.club.hidden.'+tag).each(function(club){ //only visible clubs
					club.removeClassName('hidden');
					club.addClassName('visible');
				});
			} else {
				prev = null;
				clubs.select('div.club.hidden').each(function(club){ //only hidden clubs
						club.removeClassName('hidden');
						club.addClassName('visible');
				});
			}
		});
	});	
});
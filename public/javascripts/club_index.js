document.observe('dom:loaded', function() {
	var prev = null;
	var clubs = $$('#content .clubs_container')[0];
	$$('a.taglist').each(function(elmt) {
		elmt.observe('click', function (event){
			var tag = $w(elmt.className).find(function(value){
				return value.substring(0,9) == "LEFT_TAG_";
			});
			//Restores previously hidden clubs
			if (prev != null) {
	  		$$('a.taglist.' + prev)[0].toggleClassName('selected');
				clubs.select('div.club:not(.'+prev.substring(5)+')').each(function(club){ 
					club.toggleClassName('hidden');
				});
	  	}
			//Hides all non-selected clubs if user selects a new tag
			if (prev != tag) {
				elmt.toggleClassName('selected');
				prev = tag;
				clubs.select('div.club:not(.'+tag.substring(5)+')').each(function(club){ //only visible clubs
					club.toggleClassName('hidden');
				});
	  	}
			else
				prev = null;
		});
	});	
});
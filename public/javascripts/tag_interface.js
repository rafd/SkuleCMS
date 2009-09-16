document.observe('dom:loaded', function() {
	var edit_all_flag = false; //could be done without flag, but whatever

	//$('club_submit').hide();
	$$('.edit_tags_module').each(function(elmt) {
		elmt.hide();	
	});
	
	$('edit_all_tags').observe('click', function (event){
		if (edit_all_flag){
			edit_all_flag = false;
			$$('.edit_tags_module').each(function(elmt) {
				elmt.hide();
			});	
		}else{
			edit_all_flag = true;
			$$('.edit_tags_module').each(function(elmt) {
				elmt.show();
			});	
		}
	});
	
	$$('a.edit_tag').each(function(elmt) {
		elmt.observe('click', function (event){
			event.stop();
			var tag_module = $(($w(elmt.className))[1])
			if (tag_module.visible())
				tag_module.hide();
			else
				tag_module.show();
		});
	});
	
	$$('.tags').each(function(elmt) {
		elmt.observe('click', function (event){

			if(elmt.hasClassName('selected')){
				$("club_tag_list_" + ($w(elmt.className))[1]).value = $("club_tag_list_" + ($w(elmt.className))[1]).value.sub (elmt.identify(),'');
			}else{
				$("club_tag_list_" + ($w(elmt.className))[1]).value += ' ' + elmt.identify();
			}
			elmt.toggleClassName('selected');
		});
	});
});



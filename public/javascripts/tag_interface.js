document.observe('dom:loaded', function() {
	$('club_submit').hide();
	$('no_js').hide();	
	$$('.tags').each(function(elmt) {
		elmt.observe('click', function (event){
			var club = window.location.href.substring(window.location.href.indexOf('clubs/')+6, window.location.href.indexOf('/edit_tags'))

			if(elmt.hasClassName('selected')){
				var pm = '&unselected=' + elmt.identify();
			}else{
				var pm = '&selected=' + elmt.identify();
			}
			var form = $('edit_club_'+club)

			new Ajax.Request(form.action, {
				parameters: form.serialize()+pm,
				method: 'put',
				onSuccess: function(transport) {
					elmt.toggleClassName('selected');
				}
			});
		});
	});
});



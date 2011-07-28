function bindSelected(){
	var url = window.location.pathname + "/" + $('#ojtype :selected')[0].value.toLowerCase() + '_ojees/new';
	console.log(url);
	$('a#new_oj_link')[0].href = url;
}
$(function(){
	// TIOJ => oiers/1/tioj_ojees/new
	// UVa => oier/1/uva_ojees/new
	// PKu => oier/
	if($('#ojtype').length >0 ){
		bindSelected();
		$('#ojtype').change(bindSelected);
	}
})	
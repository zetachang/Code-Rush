function bindSelected(){
	var url = $('a#new_oj_link').data('org_url') + "?ojtype=" + $('#ojtype :selected')[0].value;
	$('a#new_oj_link')[0].href = url;
}
$(function(){
    // TIOJ => oiers/zeta/ojees/new?ojtype=TIOJ
	// UVa => oier/zeta/ojees/new?ojtype=UVa
	if($('#ojtype').length >0 ){
	    $('a#new_oj_link').data('org_url', $('a#new_oj_link')[0].href);
		bindSelected();
		$('#ojtype').change(bindSelected);
	}
})	
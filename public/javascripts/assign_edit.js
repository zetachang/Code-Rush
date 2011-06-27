
function bindSelected(){
	var edit_type = $('#edit_type :selected')[0].value;
	//console.log(edit_type);
	$('#code').toggle('bind');
	$('#text').toggle('bind');
}
$(function(){
    var edit_type = $('#edit_type :selected')[0].value;
    if(edit_type == 'CODE'){
        $('#code').show();
        $('#text').hide();
    }else if(edit_type == 'TEXT'){
        $('#code').hide();
        $('#text').show();
    }
	$('#edit_type').change(bindSelected);
})
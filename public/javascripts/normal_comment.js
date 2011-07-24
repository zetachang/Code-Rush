$(document).ready(function(){
    //Normal Comment Ajax
    $('#new_comment_form')
    .live("ajax:beforeSend",function(xhr,settings){
        var $submit_button = $(this).find('input[name="commit"]');
        $submit_button.val( "Submitting..." ); 
    })
    .live("ajax:success",function(data, xhr, status){
        //Will append to the comment list in the facebox
        var comment = xhr.comment;
        var new_comment = '<div class="comment"><h4><em>'+ comment.author + ' says,</em></h4>' + 
                       '<p>' + comment.comment + '</p></div>';
        $(new_comment).appendTo('#main_comments').hide().fadeIn();
        $(this).find('textarea,input[type="text"],input[type="file"]').val("")    
    })
    .live("ajax:error", function(evt, xhr, status, error){
        console.log(error);
        var errors = xhr.responseText;
        var $error_block = $('<div class = "validation-errors"></div>');
        $error_block.text(errors);
        $(this).find('.validation-errors').detach();
        $(this).prepend($error_block);
        $error_block.hide().fadeIn();
    })
    .live("ajax:complete",function(xhr,status){
        var $submit_button = $(this).find('input[name="commit"]');
        $submit_button.val( "Submit" );
    })
})
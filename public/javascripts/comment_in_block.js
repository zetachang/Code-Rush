$(document).ready(function(){
    
    // Create Comment Ajax
    $('#facebox #new_comment_form')
    .live("ajax:beforeSend",function(xhr,settings){
        var $submit_button = $(this).find('input[name="commit"]');
        //check if this
        $submit_button.val( "Submitting..." ); 
    })
    .live("ajax:success",function(data, xhr, status){
        //Will append to the comment list in the facebox
        var comment = xhr.comment;
        var new_comment = '<div class="comment"><h4><em>'+ comment.author + ' says,</em></h4>' + 
                       '<p>' + comment.comment + '</p></div>';
        $(new_comment).appendTo($('#comments_on_' + comment.anchor));
        $(new_comment).appendTo($('.comment-facebox #comments_on_' + comment.anchor)).hide().fadeIn();
        $(this).find('textarea,input[type="text"],input[type="file"]').val("")
        $(this).hide();        
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
    
    function createCommentBox(contentId, commentId){
        var $buff = $('<div></div>');
        //refer of the content 
        $('<em>Comments for:</em>').appendTo($buff);
        $('<div class = "refer">' + $(contentId + ' p').add(contentId + ' pre').html() + '</div>').appendTo($buff);
        //comment thread
        $(commentId).clone().appendTo($buff);
        //new comment link
        $('<a href="#new_comment">New Comment</a>').appendTo($buff);
        //new comment
        $('#new_comment_form').clone().appendTo($buff).hide();
        $.facebox($buff.html(),'comment-facebox');
        $('.comment-facebox a[href="#new_comment"]').click(function(){
            $('.comment-facebox #new_comment_form').toggle('fade');
        });
    }
    
    function createContentStatus(currentId){
        //The comment list can be select by '#comments_on_cnt{number here}'
        //This div is tagged with id 'cnt{number here}'
        var commentId = "#comments_on_" + currentId;
		var obj = $('#' + currentId);
        $('<div class="content-status"></div>').appendTo('#' + currentId);
        //creat comment link
        var $commentLink;
        if($('#comments ' + commentId).find('.comment').length > 0){
            $commentLink = $('<a href="' + commentId + '">Comments</a>');
        }else{
            $commentLink = $('<a href="#new-comment">New Comment</a>');
        }
        $commentLink.appendTo('#' + currentId + ' .content-status');
        $commentLink.click(function(){
            createCommentBox('#'+ currentId, commentId);
            $('.comment-facebox form').append('<input type="hidden" name="comment[anchor]" id="comment_anchor" value="' + currentId + '"/>');
        });
    }
    
    function updateContentStatus(contentBlock){
        var commentId = '#comments_on_' + contentBlock.attr('id');
        //alert(commentId);
        if($(commentId).find(".comment").length > 0)
        {
            //remove current content-status
            contentBlock.find('.content-status').empty();
            var $commentLink;
            $commentLink = $('<a href="' + commentId + '">Comments</a>');
            $commentLink.appendTo('#' + contentBlock.attr('id') + ' .content-status');
            $commentLink.click(function(){
                createCommentBox('#'+ contentBlock.attr('id'), commentId);
                $('.comment-facebox form').append('<input type="hidden" name="comment[anchor]" id="comment_anchor" value="' + currentId + '"/>');
            });
        }
    }
    /*Iterate all p tag and wrap them with named div element*/
    $('#book').find('p').add('pre').each(function(index){
        currentId = 'cnt' + index.toString();
        $(this).wrap('<div id="' + currentId + '"></div>');
        //check if ther corresponding comments block exist
        if( $('#comments_on_' + currentId).length == 0 )
        {
            $('#comments').append('<div id="comments_on_' + currentId + '"></div>');
        }
        createContentStatus(currentId);
		$('#' + currentId).addClass("content-block"); // for styling
		$('#'+ currentId).hover(
            function(){
                $(this).addClass("hover");
                updateContentStatus($(this));
			},
            function(){
                $(this).removeClass("hover");
            }
        )
    });
})
$(document).ready(function(){
    $('#new_comment_form')
    .bind("ajax:error", function(evt, xhr, status, error){
        console.log(status);
        console.log(error);
    })
    
    
    
    /* Comment in block feature */
    function createContentStatus(obj){
        //console.log(obj.);
        $('<div class="content-status"></div>').appendTo(obj);
        /*
        var commentLink = '<a rel="facebox" href="#comments_on_' + obj.attr('id') + '">Comments</a>';
        $(commentLink).appendTo('.content-status');
        $('a[rel*=facebox]').facebox();
        */
        var commentId = "#comments_on_" + obj.attr('id');
        if($('#comments ' + commentId).length > 0){
            var commentLink = '<a href="' + commentId + '">Comments</a>';
            $(commentLink).appendTo('.content-status');
            $('a[href*="comments_on"]').click(function(){
                console.log('#comments' + commentId);
                $.facebox($('#comments ' + commentId).html(),'comment-facebox');
            })
        }else{
            var commentLink = '<a href="new_comment">New Comment</a>';
            $(commentLink).appendTo('.content-status');
        }
    }
    function removeContentStatus(obj){
        $('.content-status').detach();
    }
    $('#book').find('p').add('pre code').each(function(index){
        //console.log(index);
        currentId = 'cnt' + index.toString();
        newContentBlock = '<div id="' + currentId + '"></div>';
        //console.log(newContentBlock);
        $(newContentBlock).insertBefore($(this));
        $(this).appendTo('#' + currentId);
        $('#' + currentId).addClass("content-block");
        $('#'+ currentId).hover(
            function(){
                $(this).addClass("hover");
                createContentStatus($(this))();
            },
            function(){
                $(this).removeClass("hover");
                removeContentStatus($(this))();
            }
        )
    });
})
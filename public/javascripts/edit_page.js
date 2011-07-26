$(document).ready(function(){
    $('#comment_field .comment a').each(function(){
        $(this).hide();
    });
    $("#comment_field .comment").hover(
        function(){
            $(this).find("a").show();
        },
        function(){
            $(this).find("a").hide();
        }
    );
    $("a[data-remote]")
        .live("ajax:beforeSend",function(xhr,settings){
            $(this).parent().effect("highlight");
            //console.log('XD');
        })
        .live("ajax:success",function(xhr,data,status){
            $(this).parent().fadeOut();
        })
        .live("ajax:error",function(evt, xhr, status, error){
            //console.log(xhr);
            //console.log(status);
            //console.log(error);
            alert(xhr.responseText);
        });
        
})
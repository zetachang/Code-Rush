function replace_tioj_prob_link(obj){
	var url = "http://tioj.redirectme.net:8080/JudgeOnline/showproblem?problem_id=";
	obj.href = url + $(obj).html();
}
function replace_each_prob_link(){
    $('#tioj a.prob_link').each(function(idx,el){
		replace_tioj_prob_link(el);
	});
}
$(document).ready(function(){
	replace_each_prob_link();
	$('#update_button').closest('form')
	.bind("ajax:before",function(evt, xhr, settings){
        var $submitButton = $(this).find('input[type="submit"]');
        var $statsDiv = $('.ojstats#tioj p');
        var $errorDiv = $('.ojstats#tioj .options #update_error');
        $errorDiv.html();
        $errorDiv.hide();
        $statsDiv.animate({opacity:0.50},500);
        $submitButton.data( 'origText', $submitButton.val() );
        //console.log($submitButton.data( 'origText'));
        $submitButton.val("Updating..."); 
    })
    .bind("ajax:success",function(evt, data, status, xhr){
        //clear all the prob  
        $('.ojstats#tioj p').empty();
        //insert new from json object
        var ojee = data.tioj_ojee;
        console.log(ojee);
        $.each(ojee.problems_solved,function(idx,val){
            var newLink = '<a class="prob_link noicon">' + val + '</a> ';
            var dum = $('.ojstats#tioj p').html();
            $('.ojstats#tioj p').html(dum + newLink);
        });
        //change the number
        var number = ojee.problems_solved.length;
        $('.ojstats#tioj .options #number').show();
        $('.ojstats#tioj .options #number').html(number.toString() + ' solved');
        $('.ojstats#tioj .options #number').effect("highlight");
    })
    .bind("ajax:error",function(evt, xhr, status, error){
        //do not touch the original prob
        //show error messgae beside the option
        var $errorDiv = $('.ojstats#tioj .options #update_error');
        $errorDiv.html(xhr.responseText);
        $errorDiv.css('display','inline');        
        $('.ojstats#tioj .options #number').hide();
    })
    .bind("ajax:complete",function(evt, xhr, status){
        var $submitButton = $(this).find('input[type="submit"]');
        var $statsDiv = $('.ojstats#tioj p');
        $statsDiv.animate({opacity:1.0},1000);
        $submitButton.val($submitButton.data( 'origText'));
    });
})

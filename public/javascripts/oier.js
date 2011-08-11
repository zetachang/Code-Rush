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

var OJ = {
    "tioj" : {
        replaceEachProbLink: function(){
            $('#tioj a.prob_link').each(function(idx,el){
                var url = "http://tioj.redirectme.net:8080/JudgeOnline/showproblem?problem_id=";
        	    el.href = url + $(el).html();
        	    el.target = "_blank";
            });
        }
    },
    "zerojudge" : {
        replaceEachProbLink: function(){
            $('#zerojudge a.prob_link').each(function(idx,el){
        		var url = "http://zerojudge.tw/ShowProblem?problemid=";
        		el.href = url + $(el).html();
        		el.target = "_blank";
        	}) 
        }
    },
    "pku" : {
        replaceEachProbLink: function(){
            $('#pku a.prob_link').each(function(idx,el){
        		var url = "http://poj.org/problem?id=";
        		el.href = url + $(el).html();
        		el.target = "_blank";
        	}) 
        }
    },
    "uva" : {
        replaceEachProbLink: function(){
            $('#uva a.prob_link').each(function(idx,el){
                var url = "http://uva.onlinejudge.org/external/";
        		var id = $(el).html();
            	function  getCategory(str){
            	    tmp = "";
                	for(var i=0;i<str.length-2;i++){
                		tmp += str[i];
                	}
                	return tmp;
            	}
            	el.href = url + getCategory(id) + "/" + id + '.html';
            	el.target = "_blank";
        	});
        }
    } 
};
$(document).ready(function(){
    // manuplate with Oj prob link
    $('.ojstats').each(function(idx,el){
       OJ[$(el).attr('id')].replaceEachProbLink(); 
    });
	$('.update_button').closest('form')
	.bind("ajax:before",function(evt, xhr, settings){
        var $submitButton = $(this).find('input[type="submit"]');
        var $ojstats = $(this).closest('.ojstats');
        var $probsDiv = $ojstats.find('p');
        var $errorDiv = $ojstats.find('#update_error');
        //Clear and hide the error div
        $errorDiv.html();
        $errorDiv.hide();
        //Fading animate
        $ojstats.animate({opacity:0.50},500);
        //hide the button and replace it by loader gif
        $submitButton.hide();
        var $loaderIcon = $("<img src='/images/ajax-loader.gif'>");
        $loaderIcon.css("margin-right","5px");
        $ojstats.find('.options').append($loaderIcon);
    })
    .bind("ajax:success",function(evt, data, status, xhr){
        var $ojstats = $(this).closest('.ojstats');
        var $probsDiv = $ojstats.find('p');
        var $numberField = $ojstats.find('.options #number');
        var $mainNumberField = $('.stats_field .short_stats .' + $ojstats.attr('id') + ' a');
        //clear all the prob  
        $probsDiv.empty();
        //insert new from json object
        var ojee = data[$ojstats.attr('id') + '_ojee'];
        $.each(ojee.problems_solved,function(idx,val){
            var newLink = '<a class="prob_link noicon">' + val + '</a> ';
            var dum = $probsDiv.html();
            $probsDiv.html(dum + newLink);
        });
        //replace each link
        OJ[$ojstats.attr('id')].replaceEachProbLink();
        //change the number
        var number = ojee.problems_solved.length;
        $numberField.show();
        $numberField.html(number.toString() + ' solved');
        $numberField.effect("highlight",{},2000);
        $mainNumberField.html($mainNumberField.html().replace(/([0-9]+)/,number.toString()));
        //$mainNumberField.effect("highlight");
    })
    .bind("ajax:error",function(evt, xhr, status, error){
        //show error messgae beside the option
        var $ojstats = $(this).closest('.ojstats');
        var $errorDiv = $ojstats.find('#update_error');
        var $numberField = $ojstats.find('.options #number');
        $errorDiv.html(xhr.responseText);
        $errorDiv.css('display','inline');        
        $numberField.hide();
    })
    .bind("ajax:complete",function(evt, xhr, status){
        var $submitButton = $(this).find('input[type="submit"]');
        var $ojstats = $(this).closest('.ojstats');
        var $probsDiv = $ojstats.find('p');
        var $loaderIcon = $ojstats.find('img');
        $ojstats.animate({opacity:1.0},1000);
        $loaderIcon.detach();
        $submitButton.show();
    });
})
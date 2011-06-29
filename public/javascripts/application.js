// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//$.facebox.settings.closeImage = '/images/facebox/closelabel.png';
//$.facebox.settings.loadingImage = '/images/facebox/loading.gif';
ojtypes = ['TIOJ','PKU','ZeroJudge','UVa'];
$(document).ready(function() {
  	$.facebox.settings.closeImage = '/images/facebox/closelabel.png';
	$.facebox.settings.loadingImage = '/images/facebox/loading.gif';
	$('a[rel*=facebox]').facebox();
    SyntaxHighlighter.all();
    //$("input[type='submit']").button();
    $( "#ojtypes" ).autocomplete({
    			source: ojtypes
    });
    function clearSelected(){
        $('#sidebar a').each(function(index,ele){
            $(ele).removeClass('selected');
        })
    }
     $('a:contains("Current Assignment")').addClass("selected")
    $(".assignment.not-due").show();
    $(".assignment.due").hide();
    $('a:contains("Current Assignment")').click(function(){
        if($(this).hasClass("selected") == false)
        {
            clearSelected();
            $(this).addClass("selected");
            $(".assignment.not-due").fadeIn();
            $(".assignment.due").hide();
        }
    })
    $('a:contains("Past Assignment")').click(function(){
        if($(this).hasClass("selected") == false)
        {
            clearSelected();
            $(this).addClass("selected");
            $(".assignment.due").fadeIn();
            $(".assignment.not-due").hide();
        }
    })
    //$( "#accordion" ).accordion({autoHeight: false,navigation: true,collapsible: true});
    //$( "#tabs" ).tabs();
})
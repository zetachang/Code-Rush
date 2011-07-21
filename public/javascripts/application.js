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
    function split( val ) {
    		return val.split(/,\s*/);
    }
    function extractLast( term ) {
    	    return split( term ).pop();
    }
    $( "#ojtypes" ).autocomplete({
    			source: ojtypes
    });
    $("#code_tags").bind( "keydown", function( event ) {
    				//from official jQuery UI site, it can prevent the navigate to next item when typing tab 
    				if ( event.keyCode === $.ui.keyCode.TAB && $( this ).data( "autocomplete" ).menu.active ) {
    					    event.preventDefault();
    				    }
    			    })
    			    .autocomplete({
                        source: function(request, response){
                            $.getJSON("/codes/all_tags", {key: extractLast(request.term)},response);
                            console.log(extractLast(request.term));
                        },
                        minLength: 2,
                        focus: function(){
                            return false;
                        },
                        select: function( event, ui ) {
        					    var terms = split( this.value );
        					    terms.pop();
        					    terms.push( ui.item.value );
        					    terms.push( "" );
        					    this.value = terms.join( ", " );
        					    return false;
                        }		
                    })
    function clearSelected(){
        $('#sidebar a').each(function(index,ele){
            $(ele).removeClass('selected');
        })
    }
    //$('a:contains("Current Assignment")').addClass("selected")
    $(".assignment.not-due").show();
    $(".assignment.due").hide();
    $('a[href="#current_assignments"]').click(function(){
        if($(this).hasClass("selected") == false)
        {
            clearSelected();
            $(this).addClass("selected");
            $(".assignment.not-due").fadeIn();
            $(".assignment.due").hide();
        }
    })
    $('a[href="#past_assignments"]').click(function(){
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
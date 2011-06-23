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
    $("input[type='submit']").button();
    $( "#ojtypes" ).autocomplete({
    			source: ojtypes
    });
    $( "#accordion" ).accordion({autoHeight: false,navigation: true,collapsible: true});
    $( "#tabs" ).tabs();
})
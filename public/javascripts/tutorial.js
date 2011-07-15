$(document).ready(function(){
    $('#new_comment_link').bind("ajax:success",function(evt,data,status,xhr){
      $('#comments').append(xhr.responseText);
    });
    
    $('#new_comment_form')
        .bind("ajax:beforeSend", function(evt, xhr, settings){
            alert("xd");
            var $submitButton = $(this).find('input[name="commit"]');
            $submitButton.data('origText', $(this).text());
            $submitButton.text("Submitting...");
        })
        .bind("ajax:success", function(evt, data, status, xhr){
            console.log('XDDD');
            var $form = $(this);
            $form.find('textarea,input[type="text"],input[type="file"]').val("");
            $form.find('div.validation-error').empty();
            
            $('#comments').append(xhr.responseText)
        })
        .bind("ajax:complete",function(evt, xhr, status){
            console.log('XDDD');
            var $submitButton = $(this).find('input[name="commit"]');
            $submitButton.text( $(this).data('origText') );
        })
        .bind("ajax:error",function(evt, xhr, status, error){
            console.log("XD");
            var $form = $(this),
                      errors,
                      errorText;
            try {
                // Populate errorText with the comment errors
                errors = $.parseJSON(xhr.responseText);
            } catch(err) {
                // If the responseText is not valid JSON (like if a 500 exception was thrown), populate errors with a generic error message.
                errors = {message: "Please reload the page and try again"};
            }
            // Build an unordered list from the list of errors
            errorText = "There were errors with the submission: \n<ul>";
            for ( error in errors ) {
                errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
            }
            errorText += "</ul>";
            // Insert error list into form
            $form.find('div.validation-error').html(errorText);
        });
})
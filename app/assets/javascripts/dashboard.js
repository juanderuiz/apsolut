$(document).on('ready page:load',function(){
    
    var inputValue = $('#current_year').val();
    var quarters_year = $(".user_quarters").children();
    for (i = 0; i < quarters_year.length; i++) {
      if (!$(quarters_year[i]).hasClass(inputValue.toString())) {
        $(quarters_year[i]).addClass("hidden");
      }
    }

    //Attach function for onChange event to show Quarters for a certain year
    //Hide or Show the correct ones
    $('#current_year').click(function(){
      var newValue = $('#current_year').val();
      var current_quarters_year = $(".user_quarters").children();
      for (i = 0; i < quarters_year.length; i++) {
        if (!$(quarters_year[i]).hasClass(newValue.toString())) {
      	  //window.alert(quarters_year[i]);
          $(quarters_year[i]).addClass("hidden");
        } else {
          $(quarters_year[i]).removeClass("hidden");
        }
      }
    });

});


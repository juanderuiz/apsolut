$(document).on('ready page:load',function(){
    
    var inputValue = $('#current_year').val();
    var quarters_year = $(".user_quarters").children();
    for (i = 0; i < quarters_year.length; i++) {
      if (!$(quarters_year[i]).hasClass(inputValue.toString())) {
        $(quarters_year[i]).addClass("hidden");
      }
    }
    start();

    //Attach function for onChange event to show Quarters for a certain year
    //Hide or Show the correct ones MIRAR ESTO BIEN
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
      start();
    });

    //start();

});

function start() {
      var yearValue = $('#current_year').val();
      //var quarters_year = $(".user_quarters").children();
      var totales = document.getElementsByClassName('total_year');
      var graphs = document.getElementsByClassName('graph');
      for (j = 0; j < totales.length; j++){
        var totalString = $(totales[j]).text().split("-");
        var totalValue = Math.floor(totalString[0]*100/1440);
        //window.alert(totalValue);
        var t = radialProgress(graphs[j])
          .diameter(150)
          .value(totalValue)
          .render();
      }
}

function start2(){
  for (i = 0; i < quarters_year.length; i++) {
        if ($(quarters_year[i]).hasClass(newValue.toString())) {
          var total_cell = $(quarters_year[i]).children().last();
          if ($(total_cell).hasClass('total_year')){
            window.alert($(total_cell).text());
            var rp1 = radialProgress($(total_cell))
                .diameter(150)
                .value(78)
                .render();
          }
        }
      }
}


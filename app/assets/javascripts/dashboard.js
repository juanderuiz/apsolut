$(document).on('ready page:load',function(){
    
    var inputValue = $('#current_year').val();
    var quarters_year = $(".user_quarters").children();
    for (i = 0; i < quarters_year.length; i++) {
      if (!$(quarters_year[i]).hasClass(inputValue.toString())) {
        $(quarters_year[i]).addClass("hidden");
      }
    }
    start();
    changeDashboardInfo();

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

var myVar = setInterval(function(){ changeDashboardInfo() }, 60000);

function stopDashboardInfo(){
  clearInterval(myVar);
}

function changeDashboardInfo(){
  $("#mainmeetings").toggleClass("hidden");
  $(".tableheader").toggleClass("hidden");
  $(".user_quarters").toggleClass("hidden");
}

function start() {
      var yearValue = $('#current_year').val();
      var size = $(document).width();
      //window.alert(size);
      //var quarters_year = $(".user_quarters").children();
      var totales = document.getElementsByClassName('total_year');
      var graphs = document.getElementsByClassName('graph');
      for (j = 0; j < totales.length; j++){
        var totalString = $(totales[j]).text().split("-");
        if (totalString.length != 2){
          totalString = $(totales[j]).text().split("+");
        }
        var totalValue = Math.floor((totalString[0]*100)/1440);
        //window.alert(totalValue);
        var t = radialProgress(graphs[j])
          .diameter(150)
          .value(totalValue)
          .render();
      }
}



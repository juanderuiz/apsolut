$(".dashboards.show").on('ready',function(){

    console.log("Main page...");
    var tables = $('#smalltable').length + $('#largetable').length;
    if (tables<2) { return; }
  
    
    //When starting or reloading... set the quarters of previous year
    var inputValue = new Date().getFullYear()-1;
    $('.current_year').val();
    $('.current_year_lg').val(inputValue);
    var quarters_year = $(".user_quarters").children();
    for (i = 0; i < quarters_year.length; i++) {
      if (!$(quarters_year[i]).hasClass(inputValue)) {
        $(quarters_year[i]).addClass("hidden");
      }
    }
    start();
    changeDashboardInfo();

    //Attach function for onChange event to show Quarters for a certain year
    //Small and Medium Devices
    $('.current_year').click(function(){
      var newValue = $('.current_year').val();
      var quarters_year = $(".user_quarters").children();
      for (i = 0; i < quarters_year.length; i++) {
        if (!$(quarters_year[i]).hasClass(newValue.toString())) {
          $(quarters_year[i]).addClass("hidden");
        } else {
          $(quarters_year[i]).removeClass("hidden");
        }
      }
      start();
    });

    //Attach function for onChange event to show Quarters for a certain year
    //LG Devices
    $('.current_year_lg').click(function(){
      var newValue = $('.current_year_lg').val();
      var quarters_year = $(".user_quarters").children();
      for (i = 0; i < quarters_year.length; i++) {
        if (!$(quarters_year[i]).hasClass(newValue.toString())) {
          $(quarters_year[i]).addClass("hidden");
        } else {
          $(quarters_year[i]).removeClass("hidden");
        }
      }
      start();
    });

    //start();

//});

var windowReload = 0;
var myVar = setInterval(function(){ changeDashboardInfo(); }, 40000);


function stopDashboardInfo(){
  console.log("stopDashboardInfo method");
  clearInterval(myVar);
}

function changeDashboardInfo(){
  console.log("changeDashboardInfo");
  windowReload++;
  if (windowReload==4){
    location.reload(true);
  }
  $("#mainmeetings").toggleClass("hidden");
  $(".tableheader").toggleClass("hidden");
  $(".user_quarters").toggleClass("hidden");
}

function start() {
      console.log("Start method");
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

});
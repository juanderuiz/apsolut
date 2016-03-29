$(document).on('ready page:load',function(){
  location.reload(true);
  $("#meeting_day").datepicker({
    dateFormat: "yy-mm-dd"
  });
  
});

//jQuery ->
  //$('#meeting_day').datepicker
   // dateFormat: 'yy-mm-dd'
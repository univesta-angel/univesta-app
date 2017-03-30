$(document).ready(function(){
  $('#daterange').daterangepicker({		
       "ranges": {		
           "Today": [		
               "2017-03-30T01:19:42.901Z",		
               "2017-03-30T01:19:42.901Z"		
           ],		
           "Yesterday": [		
               "2017-03-29T01:19:42.901Z",		
               "2017-03-29T01:19:42.901Z"		
           ],		
           "Last 7 Days": [		
               "2017-03-24T01:19:42.901Z",		
               "2017-03-30T01:19:42.901Z"		
           ],		
           "Last 30 Days": [		
               "2017-03-01T01:19:42.901Z",		
               "2017-03-30T01:19:42.901Z"		
           ],		
           "This Month": [		
               "2017-02-28T16:00:00.000Z",		
               "2017-03-31T15:59:59.999Z"		
           ],		
           "Last Month": [		
               "2017-01-31T16:00:00.000Z",		
               "2017-02-28T15:59:59.999Z"		
           ]		
       },		
       "alwaysShowCalendars": true,		
       "startDate": "03/24/2017",		
       "endDate": "03/30/2017"		
   }, function(start, end, label) {		
     console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");		
   });		
 		
   $('#daterange').on('cancel.daterangepicker', function(ev, picker) {		
     $(this).val('');		
   });
   
  $(".order-prd-btn").click(function(){
      alert($(this).attr("data_id"));
      var data_id = $(this).attr("data_id");
    
      var event = new CustomEvent("initiate", {
          detail: {
            message: data_id
          },
          bubbles: true,
          cancelable: true
        } 
      );
      document.dispatchEvent(event);
    
      var product_link = document.getElementById('ae_link_'+data_id).value;
      window.open(product_link, "_self")
  });
});

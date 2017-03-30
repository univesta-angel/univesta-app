$(document).ready(function(){
  var start = moment().subtract(29, 'days');
  var end = moment();

  $('#daterange').click(function() {
    alert('hi');
  });
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
      "startDate": start,
      "endDate": end
  }, function(start, end, label) {
    //alert(start.format('YYYY-MM-DD'))
      $.ajax({
        url: "/orders",
        type: 'GET',
        data: {
          start: start.format('YYYY-MM-DD'),
          end: end.format('YYYY-MM-DD')
        },
        dataType: 'application/json',
        success: function(data){
          window.location.reload()
        }
      });
    console.log("A new date range was chosen: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
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

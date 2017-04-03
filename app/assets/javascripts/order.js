$(document).ready(function(){
  var start = moment().subtract(29, 'days');
  var end = moment();

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
    window.open("https://shopifyapp-sample.herokuapp.com/orders?start="+start.format('YYYY-MM-DD')+"&end="+end.format('YYYY-MM-DD')+"", "_self");
  });

  $('#daterange').on('cancel.daterangepicker', function(ev, picker) {
    $(this).val('');
  });
  
  $(".add-note-btn").click(function(){
      alert($(this).attr("data-id"));
    //var dataid = $(this).attr("data-id");
      $("div[data-id='"+dataid+"']").fadeToggle("slow","linear");
      var noteid = "note_"+dataid;
      var note = localStorage[noteid];
      //console.log(note)
      document.getElementById("note").value = note;
  });

  $('.save-note-btn').click(function(){
      var dataid = $(this).attr("data-id");
      var note_ = document.getElementById("note").value;
      var noteid = "note_"+dataid;
      localStorage[noteid] = note_;
      console.log("note saved")
      $("div[data-id='"+dataid+"']").fadeToggle("slow","linear"); 
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

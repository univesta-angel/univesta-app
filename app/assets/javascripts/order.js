$(document).ready(function(){
  var start = moment().subtract(29, 'days');
  var end = moment();

  $('#daterange').daterangepicker({
      "ranges": {
          'Today': [moment(), moment()],
           'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
           'Last 7 Days': [moment().subtract(6, 'days'), moment()],
           'Last 30 Days': [moment().subtract(29, 'days'), moment()],
           'This Month': [moment().startOf('month'), moment().endOf('month')],
           'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
      },
      "alwaysShowCalendars": true,
      "startDate": start,
      "endDate": end
  }, function(start, end, label) {
    //alert(start.format('YYYY-MM-DD'))
    history.pushState(null, null, window.location.pathname+"?start="+start.format('YYYY-MM-DD')+"&end="+end.format('YYYY-MM-DD'))
    //window.open("https://shopifyapp-sample.herokuapp.com/orders?start="+start.format('YYYY-MM-DD')+"&end="+end.format('YYYY-MM-DD')+"", "_self");
  });

  $('#daterange').on('cancel.daterangepicker', function(ev, picker) {
    $(this).val('');
  });
  //--------------------------------------------------------------------------------------------------------  
  $(".add-note-btn").click(function(){
      var dataid = $(this).attr("data-id");
      alert(dataid)
      $("div[data-id='"+dataid+"']").fadeToggle("slow","linear");
      var noteid = "note_"+dataid;
      var note = localStorage[noteid];
      //console.log(note)
      var note_ = document.querySelector("textarea[dataid='"+dataid+"']").value = note;
  });

  $('.save-note-btn').click(function(){
      var dataid = $(this).attr("data-id");
      var note_ = document.querySelector("textarea[dataid='"+dataid+"']").value;
      var noteid = "note_"+dataid;
      localStorage[noteid] = note_;
      console.log("note saved")
      $("div[data-id='"+dataid+"']").fadeToggle("slow","linear"); 
  });
  //--------------------------------------------------------------------------------------------------------
  
  $('input[type="checkbox"]').on('change', function(e){
    var data = [],
        loc = $('<a>', {href:window.location})[0];
    $('input[class="fulfillment_status"]').each(function(i){
      if(this.checked){
          data.push('fulfillment_status='+this.value);
      }
      else{
        loc.pathname.slice(0, loc.pathname.indexOf('fulfillment_status='+this.value))
      }
    });
    $('input[class="financial_status"]').each(function(i){
      if(this.checked){
          data.push('financial_status='+this.value);
      }
      else{
        loc.pathname.slice(0, loc.pathname.indexOf('fulfillment_status='+this.value))
      }
    });
    $('input[class="order_status"]').each(function(i){
      if(this.checked){
          data.push('order_status='+this.value);
      }
      else{
        loc.pathname.slice(0, loc.pathname.indexOf('fulfillment_status='+this.value))
      }
    });
    data = data.join('&');
    
    $.get('/orders', data);
    if(history.pushState){
        history.pushState(null, null, loc.pathname+'?'+data);
    }
  });
  
  //--------------------------------------------------------------------------------------------------------
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

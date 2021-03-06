$(document).ready(function(e){
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
        var data = {from: start.format('YYYY-MM-DD'), to: end.format('YYYY-MM-DD')};
        getOrders(data);
  });

  $('#daterange').on('cancel.daterangepicker', function(ev, picker) {
    $(this).val('');
  });
  

  $(".add-note-btn").click(function(e){
      var dataid = $(this).attr("data-id");
      $("div[data-id='"+dataid+"']").fadeToggle("linear");
  });

  $('.save-note-btn').click(function(){
      var dataid = $(this).attr("data-id");
      var order_id = $('textarea[data-id="'+dataid+'"]').attr("data-no");
      var note = document.querySelector('textarea[data-id="'+dataid+'"]').value;
      $.ajax({
        url: "/edit_note",
        type: "PUT",
        data: { note: note, order_id: order_id },
        success: function () {
          toastr.success("Note was updated successfully!")
        },
        error: function() {
          toastr.error("Failed to save the note.")
        }
      });
  });

  $('.close-note-btn').click(function(e){
      e.preventDefault();
      var dataid = $(this).attr("data-id");
      $("div[data-id='"+dataid+"']").fadeToggle("linear");
  })

  /*document.getElementById("save").addEventListener("click", function ()
    {
      var user = document.getElementById("note").value;
      //localStorage["user"] = user ;
      localStorage.note = user;
      console.log("note saved")
      $("#div1").fadeToggle("slow","linear");
  } , false);*/

  //--------------------------------------------------------------------------------------------------------

  //var checked = localStorage.getItem('checkbox1');
  var filterLinks = document.querySelectorAll('a[class="dropdown-toggle"]')
  var checkboxes = document.querySelectorAll('input[type="checkbox"][class="order-filter"]')
  for (var i = 0; i < checkboxes.length; i++) {
    var box = checkboxes[i];
    if (box.hasAttribute("value")) {
      setupBox(box);
    }
  }
  for ( var i=0; i < filterLinks.length; i++ ) {
    var link = filterLinks[i];
    if (link.hasAttribute("data-toggle")) {
      setupBox(link);
    }
  }
  //$('a.fulfillment').text(localStorage.getItem("fulfillment_link"))
  $('input[type="checkbox"][class="order-filter"]').on('change', function(e){
    var data = [],
        loc = $('<a>', {href:window.location})[0];
    $('input[class="fulfillment_status"]').each(function(i){
      if(this.checked){
        data.push('fulfillment_status[]='+this.value);
        /*localStorage.setItem("fulfillment_link", this.name)
        $('a.fulfillment').text(this.name)*/
      }
      else{
        loc.pathname.slice(0, loc.pathname.indexOf('fulfillment_status[]='+this.value))
      }
    });
    $('input[class="financial_status"]').each(function(i){
      if(this.checked){
        data.push('financial_status[]='+this.value);
      }
      else{
        loc.pathname.slice(0, loc.pathname.indexOf('financial_status[]='+this.value))
      }
    });
    $('input[class="order_status"]').each(function(i){
      if(this.checked){
        data.push('order_status[]='+this.value);
      }
      else{
        loc.pathname.slice(0, loc.pathname.indexOf('order_status[]='+this.value))
      }
    });
    data = data.join('&');
    var checkbox = document.getElementsByClassName('fulfillment_status')
    localStorage.removeItem('checkbox1')
    localStorage.setItem('checkbox1', checkbox[0].checked);
    getOrders(data)
    if(history.pushState){
        history.pushState(null, null, loc.pathname+'?'+data);
        //window.location.replace(loc.pathname+'?'+data);
    }
  });
  function setupBox(box) {
    var storageId = box.getAttribute("value");
    var oldVal    = localStorage.getItem(storageId);
    box.checked = oldVal === "true" ? true : false;

    box.addEventListener("change", function() {
        localStorage.setItem(storageId, this.checked); 
    });
  }
  function setupLink(link) {
    var storageId = link.getAttribute("value")
    var oldVal = localStorage.getItem(storageId);
    link.text()
  }
  
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
  
  //--------------------------------------------------------------------------------------------------------
  
  $(".mark-ship-btn").click(function(){
    var orderid = $(this).attr("data-id");
    $.ajax({
      url: "/mark_shipped",
      type: "POST",
      data: { order_id: orderid },
      success: function() {
        toastr.success("Order was marked as successfully fulfilled.")
      },
      error: function() {
        toastr.error("Failed to mark as shipped.")
      }
    });
  });
  
  
}); // END OF DOCUMENT.READY

function getOrders(data) {
  $.ajax({
    url: "/fetch_orders",
    type: "GET",
    data: data,
    success: function() {
      //alert('ok');
    }
  });
}
    
    

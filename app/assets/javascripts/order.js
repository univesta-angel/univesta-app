$(document).ready(function(){
  $("#order-btn").click(function(){
    
      alert($(this).find(".customername").text());
    
      var event = document.createEvent('Event');
      event.initEvent('hello');
      document.dispatchEvent(event);
      var product_link = $("#prd_link").text();
      window.open(product_link, "_self")
  });
});

$(document).ready(function(){
  $("#order-btn").click(function(){
      var event = document.createEvent('Event');
      event.initEvent('hello');
      document.dispatchEvent(event);
      var product_link = $("#prd_link").text();
      window.open(product_link, "_self")
  });
});

$("#order-btn").click(function(){
    var event = document.createEvent('Event');
    event.initEvent('hello');
    document.dispatchEvent(event);  
});

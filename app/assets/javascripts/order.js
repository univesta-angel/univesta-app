var go = function() {
  var event = document.createEvent('Event');
  event.initEvent('hello');
  document.dispatchEvent(event);
}

// The ID of the extension we want to talk to.
var editorExtensionId = "abcdefghijklmnoabcdefhijklmnoabc";

// Make a simple request:
document.getElementById('order-btn').addEventListener('click', function() {
  var go = function() {
        var event = document.createEvent('Event');
        event.initEvent('hello');
        document.dispatchEvent(event);
    }
});

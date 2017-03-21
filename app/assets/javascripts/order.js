# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
var editorExtensionId = "ohkdopmbjjcdmhcefhdafakjocmdnddp";

$('.order-prd-btn').click(function(){
  chrome.runtime.sendMessage(editorExtensionId, {openUrlInEditor: url},
    function(response) {
      if (!response.success)
        handleError(url);
  });
});

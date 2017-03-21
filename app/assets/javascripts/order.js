var editorExtensionId = "ohkdopmbjjcdmhcefhdafakjocmdnddp";

$('.order-prd-btn').click(function(event){
  event.preventDefault();
  chrome.runtime.sendMessage(editorExtensionId, {openUrlInEditor: url},
    function(response) {
      if (!response.success)
        handleError(url);
  });
});

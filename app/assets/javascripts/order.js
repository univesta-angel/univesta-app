document.getElementById("theButton").addEventListener("click",
    function() {
  window.postMessage({ type: "FROM_PAGE_TO_CONTENT_SCRIPT", 
     text: "Hello from the webpage!" }, "*");
}, false);

document.getElementById("order-btn").addEventListener("click",
    function() {
  window.postMessage({ type: "FROM_PAGE_TO_CONTENT_SCRIPT", 
     text: "Hello from the webpage!" }, "*");
}, false);

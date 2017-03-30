// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require daterangepicker
//= require image-picker
//= require trix
//= require froala_editor.min.js
//= require bootstrap-tagsinput
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function () {
  
  $('.datepicker').datepicker();
  $('input[name="datefilter"]').daterangepicker({
      "ranges": {
          "Today": [
              "2017-03-30T01:19:42.901Z",
              "2017-03-30T01:19:42.901Z"
          ],
          "Yesterday": [
              "2017-03-29T01:19:42.901Z",
              "2017-03-29T01:19:42.901Z"
          ],
          "Last 7 Days": [
              "2017-03-24T01:19:42.901Z",
              "2017-03-30T01:19:42.901Z"
          ],
          "Last 30 Days": [
              "2017-03-01T01:19:42.901Z",
              "2017-03-30T01:19:42.901Z"
          ],
          "This Month": [
              "2017-02-28T16:00:00.000Z",
              "2017-03-31T15:59:59.999Z"
          ],
          "Last Month": [
              "2017-01-31T16:00:00.000Z",
              "2017-02-28T15:59:59.999Z"
          ]
      },
      "alwaysShowCalendars": true,
      "startDate": "03/24/2017",
      "endDate": "03/30/2017"
  }, function(start, end, label) {
    console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
  });

  $('.date_range').on('cancel.daterangepicker', function(ev, picker) {
    $(this).val('');
  });
  
  var trigger = $('.hamburger'),
      overlay = $('.overlay'),
     isClosed = false;

    trigger.click(function () {
      hamburger_cross();      
    });

    function hamburger_cross() {

      if (isClosed == true) {          
        overlay.hide();
        trigger.removeClass('is-open');
        trigger.addClass('is-closed');
        isClosed = false;
      } else {   
        overlay.show();
        trigger.removeClass('is-closed');
        trigger.addClass('is-open');
        isClosed = true;
      }
  }
  
  $('[data-toggle="offcanvas"]').click(function () {
        $('#wrapper').toggleClass('toggled');
  });  
});

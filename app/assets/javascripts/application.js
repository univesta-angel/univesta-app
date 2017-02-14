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
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var todaysDate = new Date();

$(document).on("focus", "[data-behaviour~='datepicker']", function(e){
    $(this).datepicker({"format": "yyyy-mm-dd", "weekStart": 1, "autoclose": true})
    $(this).datepicker().on('changeDate', function(ev) {
    	{alert ('Changed')};

    })
    // $(this).datepicker.on('changeDate', functin(ev) {
    // 	// if (ev.date.valueOf() > todaysDate.valueOf()) {
    // 	// 	$('#alert').show().find('strong').text('Date of Birth must not be after today!');
    // 	// } else {
    //  //        $('#alert').hide();
    //  //        startDate = new Date(ev.date);
    //  //        $('#date-start-display').text($('#date-start').data('date'));    		
    // 	// }
    //     // $('#date_dob').datepicker('hide');    	
    // }) ;
});

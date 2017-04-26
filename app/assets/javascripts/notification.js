$(document).ready(function(){
	/*$(".prd-view-prices").click(function(){
		showModal($(this).attr("data-id"));
	});
	$(".close-modal").click(function(){
		
	});*/
});

function showModal(dataid){
	var modal = document.getElementById("change-price-modal-"+dataid);
	modal.style.display = "block";
}
$(document).ready(function(){
    $("#price_fm").on('click', 'li a', function(){
		$("#price_markup_toggle:first-child").text($(this).text());
		$("#price_markup_toggle:first-child").val($(this).text());
	});

    $("#cap_fm").on('click', 'li a', function(){
		$("#cap_markup_toggle:first-child").text($(this).text());
		$("#cap_markup_toggle:first-child").val($(this).text());
	});
    if($("#cap-toggle").prop("checked") == false) {
		$('.compare-at-price-mu').hide();
    }
	$("#cap-toggle").change(function(){
		if($(this).prop("checked") == true) {
			//alert($(this).prop("checked"))
			$('.compare-at-price-mu').show();
		}
		else {
			//alert($(this).prop("checked"))
			$('.compare-at-price-mu').hide();
		}
	});

	$("#settings-save-btn").click(function(){
		var price_markup = $("#price_markup").val(),
		cap_markup = $("#cap_markup").val(),
		price_operator = $("#price_markup_toggle").val(),
		cap_operator = $("#cap_markup_toggle").val();

		if($("#cap-toggle").prop("checked") == true){
			var cap_toggle = true;
		}
		else {
			var cap_toggle = false;
		}

		alert(price_markup+"---"+cap_markup+"---"+price_operator+"---"+cap_operator+"---"+cap_toggle);

		var priceOp = valChecker(price_operator);
		var capOp = valChecker(cap_operator);

		alert(priceOp+"---"+capOp);
		$.ajax({
			url: '/settings/edit_markup',
			type: 'PUT',
			data: { pmu: price_markup, capmu: cap_markup, p_operator: priceOp, c_operator: capOp, c_toggle: cap_toggle },
			success: function() {
				toastr.success('Saved successfully!');
			}
		});
	});
})

function valChecker(str) {
	var operator = "";
	if(str == "Fixed"){
		operator = "+";
	}
	else {
		operator = "*";
	}
	return operator;
}

/*
function ajaxReq(){
	var url = $('#images').data('url')
	$.getJson(url+'&callback=?', function(data){
		addNewImages(data)
	});
}

function addNewImages(data) {
	$.each(data.data, function(index, image){
		if($('#'+image.id).length==0){
			var img = $(
				'<img id="'+image.id+' src="'+image.images.low_resolution.url+'" alt=""/><br/>'
			)
			img.hide().prependTo('#images').fadeIn(2000);
		}
	})
}

*/

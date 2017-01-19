$(document).ready(function() {

	$('.btn.btn-small').click(function(){
	  
	    var x;
	    // ---------------------- PUSH FUNCTION ---------------------------
	    if (window.confirm("defaultText") == true) {
	        x = "You pressed OK!";

		    data = {
		      title: "Test Product",
		      body_html: "Sample",
		      product_type: "Sample",
		      tags: "import",
		      vendor: "Sample"
		    };

		    $.ajax({
		        type: "POST",
		        url: "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin/products.json",
		        dataType: "json",
		        data: data,
		        success: function() {
		          alert('Success!!!');
		        },
		        error: function(data) {
		          alert('ew error. check logs.');
		        }
		  	})
	      
	  	}	

  		alert(x);

    });

});
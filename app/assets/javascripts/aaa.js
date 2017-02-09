$(document).ready(function(){
    $('.asd').click(function(){
        alert('1111');
        data = {
          "product": {
            "title": "Burton Custom Freestyle 151",
            "body_html": "<strong>Good snowboard!<\/strong>",
            "vendor": "Burton",
            "product_type": "Snowboard"
          }
        }
        alert('2222');
      
    });
     $('#aaaaaa2').click(function(){
        alert('2222');
        data = {
          "product": {
            "title": "Burton Custom Freestyle 151",
            "body_html": "<strong>Good snowboard!<\/strong>",
            "vendor": "Burton",
            "product_type": "Snowboard"
          }
        }

        $.ajax({
          type: "POST",
          url: "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin/products.json",
          dataType: "json",
          data: data,
          crossDomain: true,
          beforeSend: function(xhr) {
            xhr.setRequestHeader('Access-Control-Allow-Origin', '*');
            xhr.setRequestHeader('Access-Control-Allow-Headers', '*');
          },
          success: function() {
            response.addHeader("Access-Control-Allow-Origin", "*");
            alert('Success!!!');
          },
          error: function(data) {
            alert('ew error. check logs.');
            console.log(data);
          }
        });
         alert('3333');
        
    });
     $('#aaaaaa3').click(function(){
        alert($(this).val());
        data = {
          "product": {
            "title": "Burton Custom Freestyle 151",
            "body_html": "<strong>Good snowboard!<\/strong>",
            "vendor": "Burton",
            "product_type": "Snowboard"
          }
        }

        $.ajax({
          type: "POST",
          url: "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin/products.json",
          dataType: "json",
          data: data,
          crossDomain: true,
          beforeSend: function(xhr) {
            xhr.setRequestHeader('Access-Control-Allow-Origin', '*');
            xhr.setRequestHeader('Access-Control-Allow-Headers', '*');
          },
          success: function() {
            response.addHeader("Access-Control-Allow-Origin", "*");
            alert('Success!!!');
          },
          error: function(data) {
            alert('ew error. check logs.');
            console.log(data);
          }
        });
       
        alert($(this).val());
       


    });
});
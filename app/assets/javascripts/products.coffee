# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


@paintIt = (element, backgroundColor, textColor) ->
  element.style.backgroundColor = backgroundColor
  if textColor?
    element.style.color = textColor
 
$ ->
  $("a[data-background-color]").click (e) ->
    e.preventDefault()

    alert('button pressed!');
        data = {
          "product": {
            "title": "Burton Custom Freestyle 151",
            "body_html": "<strong>Good snowboard!<\/strong>",
            "vendor": "Burton",
            "product_type": "Snowboard"
          }
        }

        alert('jgfjh')
 	
        $.ajax({
          type: "POST",
          url: "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin/products.json",
          dataType: "json",
          data: data
        });

        alert('asdfg')

    backgroundColor = $(this).data("background-color")
    textColor = $(this).data("text-color")
    paintIt(this, backgroundColor, textColor)
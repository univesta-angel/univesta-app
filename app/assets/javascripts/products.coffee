$ ->
  $("a").click (e) ->
    e.preventDefault()
    alert('aaa')
    data = {
          "product": {
            "title": "Burton Custom Freestyle 151",
            "body_html": "<strong>Good snowboard!<\/strong>",
            "vendor": "Burton",
            "product_type": "Snowboard"
          }
        }
        alert('asd')
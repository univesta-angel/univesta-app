
      $(document).ready(function(){
        // --- for each product ---
        $("#select_all").change(function(){  //"select all" change 
          $(".checkbox").prop('checked', $(this).prop("checked")); //change all ".checkbox" checked status
        });
        //".checkbox" change 
        $('.checkbox').change(function(){ 
            //uncheck "select all", if one of the listed checkbox item is unchecked
            if(false == $(this).prop("checked")){ //if this item is unchecked
                $("#select_all").prop('checked', false); //change "select all" checked status to false
            }
            //check "select all" if all checkbox items are checked
            if ($('.checkbox:checked').length == $('.checkbox').length ){
                $("#select_all").prop('checked', true);
            }
        });
        // -- for each product variant ---
        $("#select_all2").change(function(){  //"select all" change 
          $(".checkbox2").prop('checked', $(this).prop("checked")); //change all ".checkbox" checked status
        });
        //".checkbox" change 
        $('.checkbox2').change(function(){ 
            //uncheck "select all", if one of the listed checkbox item is unchecked
            if(false == $(this).prop("checked")){ //if this item is unchecked
                $("#select_all2").prop('checked', false); //change "select all" checked status to false
            }
            //check "select all" if all checkbox items are checked
            if ($('.checkbox2:checked').length == $('.checkbox2').length ){
                $("#select_all2").prop('checked', true);
            }
        });
        
        // --- hide / unhide dropwdown option ---
        $('#bulkaction').hide();
        $('#select_all').change(function () {
          if ($('#select_all').prop("checked") == true) {
              $('#bulkaction').show();
          } else {
              $('#bulkaction').hide();
          }
        }); // ---- end

        var prod_id;
        var linkid; 
        $('.price-edit').on('click',function(){
            prod_id = $(this).attr('aaa');
            linkid = $(this).attr('id');
        });

        $('.btn.btn-sm.flex-right').on('click', function(e){
          e.preventDefault();
          switch ($(this).attr('id')){
            case 'apply':
              e.preventDefault();
              var nv = $('#new_val'+prod_id).val();
              var urlpath ='';
              if (linkid=='op1a'){
                urlpath = '/edit_price';
              }
              else if(linkid=='op2a') {
                urlpath = '/edit_cap';
              }
              sendParams(nv, prod_id, urlpath);
              $('#myModal'+prod_id).modal('hide');
              break;

            case 'apply2':
              e.preventDefault();
              var nv2 = $('#multiplier'+prod_id).val();
              var urlpath2 ='';
              if (linkid=='op1b'){
                urlpath2 = '/multiply_price';
              }
              else if(linkid=='op2b'){
                urlpath2 = '/multiply_cap';
              }
              sendParams(nv2, prod_id, urlpath2);
              $('#myModal2').modal('hide');
              break;
          }
        })

        //----- keep active tab on display
        $('a[data-toggle="tab"]').on('show.bs.tab', function(e) {
            localStorage.setItem('activeTab', $(e.target).attr('href'));
        });
        var activeTab = localStorage.getItem('activeTab');
        if(activeTab){
            $('#myTab a[href="' + activeTab + '"]').tab('show');
        } // ---- end

        $("select").imagepicker({
          hide_select : true,
          show_label  : false
        })
        
      $(function() {
        $('div#froala-editor').froalaEditor({
          height: 250,
          toolbarButtons: ['paragraphFormat', 'clearFormatting' , '|', 'bold', 'italic', 'underline', 'strikeThrough', '|',  'subscript', 'superscript', '|', 'undo', 'redo' , '|', 'formatOL', 'formatUL' , '|', 'align', '|', 'outdent', 'indent', '|', 'insertImage', 'insertLink', '|', 'align' , '|', 'insertHR', '|', 'html']
        })
      });

      });

      function sendParams(nv, productid, urlpath){
        $.ajax({
          url: urlpath,
          type: 'post',
          data: {
            new_val: nv,
            productid: productid
          },
          dataType: 'application/json',
          success: function(data){
            window.location.reload()
          }
        });
      }

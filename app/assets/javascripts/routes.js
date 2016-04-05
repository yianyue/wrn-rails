
$('document').ready(function() {
  var callApi = function(){
    var inputs = $('#header input');
    var headers = {};
    for (var i = 0; i < inputs.length; i++){
      headers[$(inputs[i]).attr("name")] = ($(inputs[i]).val());
    }

    var $button = $(this);
    var path = $button.data('path');
    var method = $button.data('method');
    var index = $button.data('index');
    var $container = $('#'+index);
    // var inputs = $('#parameters input');

    // var required = {};
    // for (var i = 0; i < inputs.length; i++){
    //   required[$(inputs[i]).attr("name")] = ($(inputs[i]).val());
    // }

    if (path.match(/:/g)){
      var paramName = path.split(':')[1];
      var param = $container.find('input.params').val();
      path = path.split(':')[0] + param;
    }


    var ajaxOptions = {
      url: path,
      headers: headers,
      method: method
    };

    if (method === 'POST' || method === 'PUT'){
      ajaxOptions.data = {data: JSON.parse($container.find('.post-data').val())};
    }
    // console.log(path, headers);

    $.ajax(ajaxOptions)
    .done( function(response) {
      $container.find('.response').html('<pre class="panel">' + JSON.stringify(response, null, 2) + '</pre>')
    }).fail( function(error) {
      $container.find('.response').html('<pre class="panel panel-danger">' + JSON.stringify(error, null, 2) + '</pre>')

    })
  }

  if($('body.test').length){
    $("button.request").click( function() {
      callApi.bind(this)()
    })
  }

});

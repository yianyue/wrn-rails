
$('document').ready(function() {
  var callApi = function(){
    var $button = $(this);
    var path = $button.data('path');
    var method = $button.data('method');

    // var inputs = $('#parameters > input');
    // var required = {};
    // for (var i = 0; i < inputs.length; i++){
    //   required[$(inputs[i]).attr("name")] = ($(inputs[i]).val());
    // }

    if (path.match(/:/g)){
      var paramName = path.split(':')[1];
      var param = $button.next('div').find('input').val();
      path = path.split(':')[0] + param;
    }

    var inputs = $('#header > input');
    var headers = {};
    for (var i = 0; i < inputs.length; i++){
      headers[$(inputs[i]).attr("name")] = ($(inputs[i]).val());
    }

    $.ajax({
      url: path,
      headers: headers,
      method: method
    }).done( function(response) {
      $button.siblings('div.response').text(JSON.stringify(response))
    }).fail( function(error) {
      $button.siblings('div.response').text(JSON.stringify(error))
    })
  }

  if($('body.test').length){
    $("button.request").click( function() {
      callApi.bind(this)()
    })
  }

});

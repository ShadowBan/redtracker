$.each($('.tzdate'),function(){
    var date = new Date($(this).text());
    $(this).html(getNicerDate(date) + " at " + getNiceTime(date));
  }
);

$('.fp-post a').click(function(e){
  var html = $(this);
  $.ajax({
    url: html.attr("href"),
    data: {},
    type: 'GET',
    dataType: 'js',
    complete: function(data,status,jqXHR) {
      var pdata = data;
      html.replaceWith(data.responseText);
    }
  });
  return false;
})



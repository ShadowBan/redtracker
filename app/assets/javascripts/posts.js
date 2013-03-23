$.each($('.utc-date'),timeZoneDates);

$('.fp-post a').click(function(e){
  var $link = $(this);
  $.ajax({
    url: $link.attr("href"),
    data: {},
    type: 'GET',
    dataType: 'script',
    complete: function(data,status,jqXHR) {
      $link.replaceWith(data.responseText);
    }
  });
  return false;
})

$(window).scroll(function()
{
  if($(window).scrollTop() == $(document).height() - $(window).height())
  {
    var $loadmore = $('#load-more')
    if ( $loadmore.length ){
      $.ajax({
        url: $loadmore.children('a').attr("href"),
        data: {},
        type: 'GET',
        dataType: 'script',
        complete: function(data,status,jqXHR) {
          $loadmore.replaceWith(data.responseText);
          $.each($('.utc-date'),timeZoneDates);
        }
      });
    }
  }
});

function timeZoneDates(){
  var date = new Date($(this).text());
  $(this).html(getNicerDate(date) + " at " + getNiceTime(date));
  $(this).removeClass("utc-date").addClass("tzdate");
}


//Run on Load
prepPosts();
$("#stream").delegate(".fp-post a","click", getFirstPost);

$(window).scroll(function(){if($(window).scrollTop() == $(document).height() - $(window).height()){getMorePosts();}});

//Function Declarations
function prepPosts(){
  $.each($('.utc-date'),timeZoneDates);
}

function getMorePosts(){
  var $loadmore = $('#load-more')
  if ( $loadmore.length ){
    $.ajax({
      url: $loadmore.children('a').attr("href"),
      data: {},
      type: 'GET',
      dataType: 'script',
      complete: function(data,status,jqXHR) {
        $loadmore.replaceWith(data.responseText);
        prepPosts();
      }
    });
  }
}

function getFirstPost(){
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
}

function timeZoneDates(){
  var date = new Date($(this).text());
  $(this).html(getNicerDate(date) + " at " + getNiceTime(date));
  $(this).removeClass("utc-date").addClass("tzdate");
}




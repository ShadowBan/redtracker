$(".category").change(function() {
    $(this).siblings('label').toggleClass("off");
    if($(this).hasClass('root')){
      if(this.checked) {
        $(this).find('~ ul > li > label').removeClass("off");
        $(this).find('~ ul > li > input').prop("checked", true);
      }else{
        $(this).find('~ ul > li > label').addClass("off");
        $(this).find('~ ul > li > input').removeAttr("checked");  
      }
    }else{
      if(this.checked) {
        $(this).parent().parent().parent().find('> label').removeClass("off");
        $(this).parent().parent().parent().find('> input').prop("checked", true);
      }
    }
    updateStream($(this).closest("form"))
});


function updateStream($form){
  $.ajax({
    url: $form.attr("action"),
    data: $form.serialize(),
    type: 'GET',
    dataType: 'script',
    complete: function(data,status,jqXHR) {
      $('#stream').html(data.responseText);
    }
  });
  return false;
}
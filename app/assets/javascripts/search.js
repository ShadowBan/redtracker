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
    }
});
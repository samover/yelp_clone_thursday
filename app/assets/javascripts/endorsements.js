$(document).ready(function(){
  $('.endorsements-link').on('click', function(event){
    event.preventDefault();
    var endorsementCount = $(this).siblings('.endorsements_count');
    $.post(this.href, function(res){
      endorsementCount.text(res.new_endorsement_count);
      $('.endorsements-link').hide();
    });
  });
});

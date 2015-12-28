$(function(){
  $('#user_profile_intro').on('click', function(event){
    event.preventDefault();
    var target = event.currentTarget.baseURI;
    $.ajax({
      method: 'GET',
      url: target,
      dataType: 'json'
      }).done(function(msg){
        $('#user_show').html(msg[2])
    });
  });
});

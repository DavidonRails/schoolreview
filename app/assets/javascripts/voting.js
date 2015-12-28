$(document).ready(function() {
  $('.upvote_review').on("click", function(event) {
    event.preventDefault();
    var target = event.currentTarget.href;
    $.ajax({
      method: 'PUT',
      url: target,
      success: function(data){
        if(data[2] === true){
          $('.update-rating-' + data[0].id).html(
            data[1]
          )} else {
            alert('You need to sign in to vote!')
        };
      }
    });
  });

  $('.downvote_review').on("click", function(event) {
    event.preventDefault();
    var target = event.currentTarget.href;
    $.ajax({
      method: 'PUT',
      url: target,
      success: function(data){
        if(data[2] === true){
          $('.update-rating-' + data[0].id).html(
            data[1]
          )} else {
            alert('You need to sign in to vote!')
        };
      }
    });
  });
});

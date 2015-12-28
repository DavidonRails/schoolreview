$(function(){
  $("#user_program_attendancy_location").change(function(){
    var institutionId = this.value
    $.ajax({
      method: 'GET',
      url: '/institutions/' + institutionId,
      dataType: 'json'
    }).done(function(msg){
      $("#user_program_attendancy_program_id > option").replaceWith("");
      for(var i = 0; i < msg[0].length; i++) {
        var programId = msg[0][i].id;
        var programName = msg[0][i].title;

      $("#user_program_attendancy_program_id").append($('<option>', {value: programId,
                    text: programName
        }));
      }
    });
  });
});

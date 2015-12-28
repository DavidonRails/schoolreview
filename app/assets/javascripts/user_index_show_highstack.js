document.addEventListener("DOMContentLoaded", function(event) {
  $('#user-index-show').ready(function(){
    var targetUrl = event.currentTarget.URL;

    $.ajax({
      method: 'GET',
      url: targetUrl,
      dataType: 'json'
    }).done(function(msg){
      var categoryList = msg[0];
      var seriesList = msg[1];

      $('#user-index-show').highcharts({
          chart: {
              type: 'bar'
          },
          title: {
              text: 'Skill leaderboard'
          },
          xAxis: {
              categories: categoryList
          },
          yAxis: {
              min: 0,
              title: {
                  text: 'Total skill points'
              }
          },
          legend: {
              reversed: true
          },
          plotOptions: {
              series: {
                  stacking: 'normal'
              }
          },
          series: seriesList
      });
    });
  })
});

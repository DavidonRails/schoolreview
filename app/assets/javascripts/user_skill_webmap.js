document.addEventListener("DOMContentLoaded", function(event) {
  console.log("user-skill", event);
  var targetUrl = event.target.URL;

    $.ajax({
      method: 'GET',
      url: targetUrl,
      dataType: 'json'
    }).done(function(input){
      categoryList = []
      priceList = []
        for(var key in input[0]){
          if(input[0].hasOwnProperty(key)){
            categoryList.push(key);
            priceList.push(input[0][key]);
          }
        }
    $('#container-user-skill-webmap').highcharts({
     chart: {
         polar: true,
         type: 'line'
     },

     title: {
         text: 'My skill set',
         x: -80
     },

     pane: {
         size: '80%'
     },

     xAxis: {
         categories: categoryList,
         tickmarkPlacement: 'on',
         lineWidth: 0
     },

     yAxis: {
         gridLineInterpolation: 'polygon',
         lineWidth: 0,
         min: 0
     },

     tooltip: {
         shared: true,
         pointFormat: '<span style="color:{series.color}">{series.name}: <b>{point.y:,.0f}</b><br/>'
     },

     legend: {
         align: 'right',
         verticalAlign: 'top',
         y: 70,
         layout: 'vertical'
     },

     series: [{
         name: 'Skill learned',
         data: priceList,
         pointPlacement: 'on'
     }]
    });
  });
});
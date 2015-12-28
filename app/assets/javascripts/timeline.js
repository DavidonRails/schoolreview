document.addEventListener("DOMContentLoaded", function(event) {
  $("#timeline-embed").ready(function(){
    var targetUrl = event.currentTarget.URL;
    $.ajax({
      method: 'GET',
      url: targetUrl,
      dataType: 'json'
    }).done(function(data){
      var timeline_json = formatData(data);
      timeline = new TL.Timeline('timeline-embed', timeline_json);
    });
  });
});

function formatData(data){
  var input = data[1];
  var events = [];

  for(var i=0; i<input.length; i++) {
    var item = input[i]
     events.push({
       "start_date": {
           "year":         item[0].start_date.split("-")[0],
           "month":        item[0].start_date.split("-")[1],
           "day":          item[0].start_date.split("-")[2],
           "hour":         "",
           "minute":       "",
           "second":       "",
           "millisecond":  "",
           "format":       ""
       },
        "end_date": {
           "year":         item[0].end_date.split("-")[0],
           "month":        item[0].end_date.split("-")[1],
           "day":          item[0].end_date.split("-")[2],
           "hour":         "",
           "minute":       "",
           "second":       "",
           "millisecond":  "",
           "format":       ""
       },
       "media": {
           "caption":      "",
           "credit":       "",
           "url":          item[0].url,
           "thumbnail":    item[0].url
       },
       "text": {
           "headline": item[2].title,
           "text":     item[2].description || "Missing text"
       }
     });
  };

  var targetJson = {
    "title": {
           "media": {
               "caption":      "",
               "credit":       "",
               "url":          data[1][0][1].profile_photo.url,
               "thumbnail":    data[1][0][1].profile_photo.url
           },
           "text": {
               "headline":     data[1][0][1].first_name + "\'s timeline",
               "text":         "Checkout my timeline"
           }
   },
   "events": events
  };
  return targetJson;
};

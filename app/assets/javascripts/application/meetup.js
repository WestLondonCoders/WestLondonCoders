function fetchGroups(url, cb, data) {
  if(!data) data = [];
  $.ajax({
    dataType:'jsonp',
    method:'get',
    url:url,
    success:function(result) {
      data.push.apply(data, result.data);
      if(result.meta.next_link) {
        var nextUrl = result.meta.next_link;
        fetchGroups(nextUrl, cb, data);
      }
      else {
        cb(data);
      }
    }
  });
};

var findLogo = function (venueName) {
  if (venueName == "YOOX NET-A-PORTER") {
    return "<img src='http://stevebrewer.uk/img/nap.svg' class='m-card__logo'>";
  }
  if (venueName == "Sky Head Office and Broadcasting Facilities") {
    return "<img src='http://stevebrewer.uk/img/sky.svg' class='m-card__logo'>";
  }
  return "";
}

calcDate = function(ms) {
  date = new Date(ms);
  var dateArray = date.toString().split(" ");
  var formattedDate = dateArray[0] + " " + dateArray[2] + " " + dateArray[1]
  return formattedDate;
};

$(document).on('turbolinks:load', function() {
  var $meetupLink      = $('#next-meetup-link');
  var $meetupCount     = $('#next-meetup-count');
  var $meetupDate      = $('#next-meetup-date');
  var $meetupVenueName = $('#next-meetup-venue-name');
  var $meetupVenue     = $('#next-meetup-venue');
  var $meetupList      = $('#meetup-list');

  fetchGroups("https://api.meetup.com/West-London-Coders/events?photo-host=public&page=1&sig_id=202775078&sig=7106b5f894f37222f896b703e3a9c6e95f5a65a4", function(res) {

    var link       = "";
    var rvspCount  = "";
    var eventDate  = "";
    var venueName  = "";
    var venue      = "";
    var meetupList = "";

    link          += "<a href='" + res[0].link + "' target='_blank' class='a-button'>RSVP</a>";
    rvspCount     += res[0].yes_rsvp_count;
    milliseconds  = res[0].time;
    eventDate     = calcDate(milliseconds);
    venueName     = res[0].venue.name;
    venue         = res[0].venue.address_1;

    for (var i=0; i < res.length; i++) {
      var meetup = res[i];
      var logo = findLogo(res[i].venue.name);

      meetupList += "<div class='m-card m-card--meetup'>" +
                    "<h1>" + "<a href='" + res[i].link + "' target='_blank'>" + calcDate(res[i].time) + "</a></h1>" +
                    logo +
                    "<h3>" + res[i].yes_rsvp_count + " going</h3>" +
                    "<a class='a-button' href='" + res[i].link + "'>RSVP</a>" +
                    "</div>";
    }

    $meetupLink.html(link);
    $meetupCount.html(rvspCount);
    $meetupDate.html(eventDate);
    $meetupVenueName.html("at " + venueName);
    $meetupVenue.html("<a href='http://maps.google.com/?q=" + venue + "' target='_blank'>" + venue + "</a>");
    $meetupList.html(meetupList);
  });
});

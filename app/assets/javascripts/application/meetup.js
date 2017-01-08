function fetchGroups(url, cb, data) {
  if(!data) data = [];
  $.ajax({
    dataType:'jsonp',
    method:'get',
    url:url,
    success:function(result) {
      console.log('back with ' + result.data.length +' results');
      console.dir(result);
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

calcDate = function(ms) {
  date = new Date(ms);
  var dateArray = date.toString().split(" ");
  var formattedDate = "On " + dateArray[0] + " " + dateArray[2] + " " + dateArray[1]
  return formattedDate;
};

$(document).ready(function() {
  var $meetupLink = $('#next-meetup-link');
  var $meetupCount = $('#next-meetup-count');
  var $meetupDate = $('#next-meetup-date');
  var $meetupVenueName = $('#next-meetup-venue-name');
  var $meetupVenue = $('#next-meetup-venue');

  $meetupCount.html("");
  fetchGroups("https://api.meetup.com/West-London-Coders/events?photo-host=public&page=1&sig_id=202775078&sig=7106b5f894f37222f896b703e3a9c6e95f5a65a4", function(res) {

    var link      = "";
    var rvspCount = "";
    var eventDate = "";
    var venueName = "";
    var venue     = "";

    link          += "<a href='" + res[0].link + "' target='_blank' class='a-button'>RSVP</a>";
    rvspCount     += res[0].yes_rsvp_count;
    milliseconds  = res[0].time;
    eventDate     = calcDate(milliseconds);
    venueName     = res[0].venue.name;
    venue         = res[0].venue.address_1;

    $meetupLink.html(link);
    $meetupCount.html(rvspCount);
    $meetupDate.html(eventDate);
    $meetupVenueName.html("at " + venueName);
    $meetupVenue.html("<a href='http://maps.google.com/?q=" + venue + "' target='_blank'>" + venue + "</a>");
  });
});



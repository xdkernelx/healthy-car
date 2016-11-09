var map;
var infowindow;
var service;

function initMap() {

  navigator.geolocation.getCurrentPosition(function(position) {
      var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };

      map = new google.maps.Map(document.getElementById('map'), {
        center: pos,
        zoom: 15
      });

      infowindow = new google.maps.InfoWindow();

      service = new google.maps.places.PlacesService(map);
      service.nearbySearch({
        location: pos,
        radius: 2000,
        type: ['car_repair']
      }, callback);
  });
}

function callback(results, status) {
  console.log(results)
  if (status === google.maps.places.PlacesServiceStatus.OK) {
    for (var i = 0; i < results.length; i++) {
      createMarker(results[i]);

    }
  }
}

function createMarker(place) {
  var placeLoc = place.geometry.location;
      var request = { reference: place.reference };
  var marker = new google.maps.Marker({
    map: map,
    position: place.geometry.location
  });

  service.getDetails(request, function(details, status) { 
      var name = details.name
      var address = details.formatted_address
      var website = details.website
      var rating = details.rating
      var phone = details.formatted_phone_number
      var content = (name + "<br />" + address +"<br /><a href="+ website +">" + website + "</a><br />" + rating + "<br />" + phone);
      google.maps.event.addListener(marker, 'click', function() {
        infowindow.setContent(content);
        infowindow.open(map, this);
      });
  })
}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
  infoWindow.setPosition(pos);
  infoWindow.setContent(browserHasGeolocation ?
                        'Error: The Geolocation service failed.' :
                        'Error: Your browser doesn\'t support geolocation.');
}
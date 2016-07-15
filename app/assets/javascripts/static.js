var map;
var placeMarker = null;
var markers = [];
var filteroption = "all";
var boundary = {
  leftpos: 0,
  rightpos: 0,
  toppos: 0,
  bottompos: 0
};
var currentPos = {
  latitude: 0,
  longitude: 0
};

var getGeolocation = function() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(generateMap);
  } else {
    generateMap({coords: {
      latitude: 32.8242404,
      longitude: -117.375352
    }});
  }
};

var initMap = function() {
  getGeolocation();
};

var clearMarkers = function() {
  for (var i=0; i < markers.length; i++) {
    markers[i].setMap(null);
  }
  markers = [];
};

var generateMap = function(position) {
  currentPos.latitude = position.coords.latitude;
  currentPos.longitude = position.coords.longitude;
  map = new google.maps.Map(document.getElementById('poke-map'), {
    center: {lat: position.coords.latitude, lng: position.coords.longitude},
    zoom: 15
  });

  google.maps.event.addListener(map, 'click', function(e){
    if (placeMarker != null) {
      var latLng = e.latLng;
      $("#placemarker-lat").val(latLng.lat());
      $("#placemarker-lng").val(latLng.lng());
      placeMarker.setPosition({lat: latLng.lat(), lng: latLng.lng()});
    }
  });

  google.maps.event.addListener(map, 'idle', function(ev){
    var bounds = map.getBounds();
    var ne = bounds.getNorthEast();
    var sw = bounds.getSouthWest();
    boundary.toppos = ne.lat();
    boundary.rightpos = ne.lng();
    boundary.bottompos = sw.lat();
    boundary.leftpos = sw.lng();
    createMarkers(filteroption);
  });
}

var createMarkers = function(option) {
  clearMarkers();
  var urlstring = "";
  if (option == "all") {
    urlstring = "/allnear?recent=true&";
  } else if (option == "allspawn") {
    urlstring = "/pokespawns?recent=false&";
  } else if (option == "nearspawn") {
    urlstring = "/pokespawns?recent=true&";
  } else if (option == "stop") {
    urlstring = "/pokestops?";
  } else if (option == "gym") {
    urlstring = "/gyms?";
  }
  urlstring += "top=" + boundary.toppos + "&right=" + boundary.rightpos + "&bottom=" + boundary.bottompos + "&left=" + boundary.leftpos;
  $.ajax({
    type: "GET",
    url: urlstring,
    dataType: "json"
  }).done(function(res){
    generateMarkers(res);
  });
};

var generateMarkers = function(data) {
  for (var i = 0; i < data.gyms.length; i++) {
    generateMarker(data.gyms[i],"gym");
  }
  for (var i = 0; i < data.stops.length; i++) {
    generateMarker(data.stops[i],"stop");
  }
  for (var i = 0; i < data.spawns.length; i++) {
    generateMarker(data.spawns[i],"spawn");
  }
};

var generateMarker = function(data,type) {
  if (type == "gym") {
    var icon_url = gym_image;
  } else if (type == "stop") {
    var icon_url = "http://orig03.deviantart.net/d388/f/2015/136/d/8/deluge_by_xillra-d8tngys.png";
  } else if (type == "spawn") {
    var icon_url = "http://orig12.deviantart.net/cee0/f/2014/279/4/b/eevee_adoptable_2__open_10_pts__by_master_user-d81v3rg.png";
  }
  var imageMarker = new google.maps.Marker({
    position: {lat: parseFloat(data.latitude), lng: parseFloat(data.longitude)},
    map: map,
    icon: { 
      url: icon_url,
      size: new google.maps.Size(25, 25), 
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(13, 25),
      scaledSize: new google.maps.Size(25, 25)
    },
    zIndex: 1
  });

  markers.push(imageMarker);
};

var resizeMap = function() {
  $("#poke-map").css("height", ($(window).height() - 50) + "px");
}

var addPlaceMarker = function(type) {
  if (placeMarker != null) {
    placeMarker.setMap(null);
  }
  if (type == "gym") {
    var icon_url = gym_image;
  } else if (type == "stop") {
    var icon_url = "http://orig03.deviantart.net/d388/f/2015/136/d/8/deluge_by_xillra-d8tngys.png";
  } else if (type == "mon") {
    var icon_url = "http://orig12.deviantart.net/cee0/f/2014/279/4/b/eevee_adoptable_2__open_10_pts__by_master_user-d81v3rg.png";
  }
  placeMarker = new google.maps.Marker({
    position: {lat: currentPos.latitude, lng: currentPos.longitude},
    map: map,
    icon: { 
      url: icon_url,
      size: new google.maps.Size(25, 25), 
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(13, 25),
      scaledSize: new google.maps.Size(25, 25)
    },
    draggable: true,
    animation: google.maps.Animation.DROP
  });

  google.maps.event.addListener(placeMarker, 'dragend', function(e){
    var latLng = e.latLng;
    $("#placemarker-lat").val(latLng.lat());
    $("#placemarker-lng").val(latLng.lng());
  });
};

var loadForm = function(ev) {
  ev.preventDefault();
  var type = $(this).attr("id").split("-").slice(-1)[0];
  if (type == "gym") {
    var urlstring = "/gyms/new"; 
  } else if (type == "stop") {
    var urlstring = "/pokestops/new";
  } else if (type == "mon") {
    var urlstring = "/pokespawns/new";
  }
  $.ajax({
    type: "GET",
    url: urlstring,
    dataType: "json"
  }).done(function(res){
    $(".control-container").html(res.attachmentPartial);
  });
  addPlaceMarker(type);
}

var ready = function() {
  
  resizeMap();

  $("#add-gym").click(loadForm);
  $("#add-stop").click(loadForm);
  $("#add-mon").click(loadForm);

  $("#show-gyms").click(function(ev){
    ev.preventDefault();
    filteroption = "gym";
    createMarkers("gym");
  });

  $("#show-stops").click(function(ev){
    ev.preventDefault();
    filteroption = "stop";
    createMarkers("stop");
  });

  $("#show-all").click(function(ev){
    ev.preventDefault();
    filteroption = "all";
    createMarkers("all");
  });

  $("#recent-poke").click(function(ev){
    ev.preventDefault();
    filteroption = "nearspawn";
    createMarkers("nearspawn");
  });

  $("#all-poke").click(function(ev){
    ev.preventDefault();
    filteroption = "allspawn";
    createMarkers("allspawn");
  });

  $("#filter-toggle").click(function(ev){
    ev.preventDefault();
    $(".control-area").removeClass("active");
    $(".menu").removeClass("active");
    $(".map-controls").toggleClass("active");
  });

  $("#open-add").click(function(ev){
    ev.preventDefault();
    $(".map-controls").removeClass("active");
    $(".menu").removeClass("active");
    $(".control-area").toggleClass("active");
  });

  $("#menu-open").click(function(ev){
    ev.preventDefault();
    $(".control-area").removeClass("active");
    $(".map-controls").removeClass("active");
    $(".menu").toggleClass("active");
  });

};

$(document).on('ready page:load', ready);

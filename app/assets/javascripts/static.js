var map;
var markers = [];
var filteroption = "all";
var boundary = {
  leftpos: 0,
  rightpos: 0,
  toppos: 0,
  bottompos: 0
}

var initMap = function() {
  generateMap();
};

var clearMarkers = function() {
  for (var i=0; i < markers.length; i++) {
    markers[i].setMap(null);
  }
  markers = [];
};

var generateMap = function() {
  map = new google.maps.Map(document.getElementById('poke-map'), {
    center: {lat: 32.8242404, lng: -117.375352},
    zoom: 7
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
    var icon_url = "https://upload.wikimedia.org/wikipedia/en/e/ee/Pokemon_icon.png";
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
      anchor: new google.maps.Point(0, 32),
      scaledSize: new google.maps.Size(25, 25)
    },
    zIndex: 1
  });

  markers.push(imageMarker);
};

var resizeMap = function() {
  $("#poke-map").css("height", ($(window).height() - 90) + "px");
}

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
  console.log(urlstring);
  $.ajax({
    type: "GET",
    url: urlstring,
    dataType: "json"
  }).done(function(res){
    console.log(res);
    $(".control-container").html(res.attachmentPartial);
  });
}

var ready = function() {
  
  resizeMap();

  $("#add-gym").click(loadForm);
  $("#add-stop").click(loadForm);
  $("#add-mon").click(loadForm);

  $("#show-gyms").click(function(ev){
    ev.preventDefault();
    createMarkers("gym");
  });

  $("#show-stops").click(function(ev){
    ev.preventDefault();
    createMarkers("stop");
  });

  $("#show-all").click(function(ev){
    ev.preventDefault();
    createMarkers("all");
  });

  $("#recent-poke").click(function(ev){
    ev.preventDefault();
    createMarkers("nearspawn");
  });

  $("#all-poke").click(function(ev){
    ev.preventDefault();
    createMarkers("allspawn");
  });

};

$(document).on('ready page:load', ready);

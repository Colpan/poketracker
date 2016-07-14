var map,markers;
var filteroption = "all";
var bounds = {
  leftpos: 0,
  rightpos: 0,
  toppos: 0,
  bottompos: 0
}

var initMap = function() {
  generateMap();
};

var clearMarkers = function() {
  
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
    console.log(ne.lat(),ne.lng(),sw.lat(),sw.lng());
    var toppos = ne.lat();
    bounds.toppos = toppos;
    bounds.rightpos = ne.lng();
    bounds.bottompos = sw.lat();
    bounds.leftpos = sw.lng();
    createMarkers(filteroption);
  });
}

var createMarkers = function(option) {
  var urlstring = "";
  if (option == "all") {
    urlstring = "/allnear?recent=true&";
  } else if (option == "allspawn") {
    urlstring = "/pokespawns?recent=false&";
  } else if (option == "nearspawn") {
    // PASS THE CURRENT LAT LNG
    urlstring = "/pokespawns?recent=true&";
  } else if (option == "stop") {
    urlstring = "/pokestops?";
  } else if (option == "gym") {
    urlstring = "/gyms?";
  }
  urlstring += "top=" + bounds.toppos + "&right=" + bounds.rightpos + "&bottom=" + bounds.bottompos + "&left=" + bounds.leftpos;
  $.ajax({
    type: "GET",
    url: urlstring,
    dataType: "json"
  }).done(function(res){
    console.log(res);
  });


  /*console.log(etchings);
  for (var i = 0; i < etchings.length; i++) {
    var imageMarker = new google.maps.Marker({
      position: {lat: parseFloat(etchings[i].latitude), lng: parseFloat(etchings[i].longitude)},
      map: map,
      icon: etchings[i].media_url
    });

    var contentString = '<h4>' + etchings[i].etching_name + '</h4>' + etchings[i].etching_description + "<div><a href='" + etchings[i].etching_url + "'>View Etching</a></div>";
    var infowindow = new google.maps.InfoWindow({
      content: contentString
    });

    imageMarker.addListener('click', function() {
      console.log("mew");
      infowindow.open(map, imageMarker);
    });
  }*/
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

};

$(document).on('ready page:load', ready);

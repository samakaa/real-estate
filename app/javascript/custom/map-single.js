(function ($) {
    "use strict";

    function mainMap() {
        var locations = JSON.parse(document.getElementById("map-single").dataset.locations);

        // Default map options
        var mapZoomAttr = $("#map-single").attr("data-map-zoom");
        var mapScrollAttr = $("#map-single").attr("data-map-scroll");

        var zoomLevel = mapZoomAttr ? parseInt(mapZoomAttr) : 5;
        var scrollEnabled = mapScrollAttr ? mapScrollAttr === "true" : false;

        // Initialize the map
        var map = new google.maps.Map(document.getElementById("map-single"), {
            zoom: zoomLevel,
            scrollwheel: scrollEnabled,
            center: new google.maps.LatLng(locations[0].latitude, locations[0].longitude),
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            styles: [/* Add your custom styles here */],
        });

        // Add markers
        locations.forEach(function (location) {
            var marker = new google.maps.Marker({
                position: new google.maps.LatLng(location.latitude, location.longitude),
                map: map,
                title: location.title,
            });

            var infowindow = new google.maps.InfoWindow({
                content: `<div><h4>${location.title}</h4><p>${location.address}</p></div>`,
            });

            marker.addListener("click", function () {
                infowindow.open(map, marker);
            });
        });
    }

    if (document.getElementById("map-single")) {
        google.maps.event.addDomListener(window, "load", mainMap);
    }
})(jQuery);

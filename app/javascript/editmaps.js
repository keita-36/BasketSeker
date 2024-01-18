let editMap;
let marker;

export function initMap() {
    const editMapElement = document.getElementById('edit-map');
    const latitude = parseFloat(editMapElement.getAttribute('data-latitude'));
    const longitude = parseFloat(editMapElement.getAttribute('data-longitude'));

    let LatLng = new google.maps.LatLng(latitude, longitude);

    editMap = new google.maps.Map(editMapElement, {
        center: LatLng,
        zoom: 15,
        gestureHandling: 'cooperative',
        mapTypeControlOptions: {
            style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
            position: google.maps.ControlPosition.TOP_LEFT,
            mapTypeIds: ['roadmap', 'terrain']
        }
    });

    editMap.addListener('click', function(e) {
        addMarker(e.latLng);
        document.getElementById('event_latitude').value = e.latLng.lat();
        document.getElementById('event_longitude').value = e.latLng.lng();
        document.getElementById('latitude_text').innerText = e.latLng.lat();
        document.getElementById('longitude_text').innerText = e.latLng.lng();

        const geocoder = new google.maps.Geocoder();
        geocoder.geocode({ location: e.latLng }, function(results, status) {
            if (status === 'OK') {
                if (results[0]) {
                    document.getElementById('address_text').innerText = results[0].formatted_address;
                } else {
                    window.alert('No results found');
                }
            } else {
                window.alert('Geocoder failed due to: ' + status);
            }
        });
    });

    addMarker({ lat: latitude, lng: longitude });
}

export function addMarker(location) {
    if (marker) {
        marker.setMap(null);
    }

    marker = new google.maps.Marker({
        position: location,
        map: editMap
    });
}

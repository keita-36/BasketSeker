document.addEventListener("DOMContentLoaded", function(){
    const mapElement = document.getElementById('map');
    const lat = mapElement.dataset.lat;
    const lng = mapElement.dataset.lng;

    const LatLng = new google.maps.LatLng(lat, lng);

    const map = new google.maps.Map(mapElement, {
        center: LatLng,
        zoom: 15,
    });

    const marker = new google.maps.Marker({
        position: LatLng,
        map: map,
    });
});

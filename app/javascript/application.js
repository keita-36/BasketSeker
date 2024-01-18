// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./channels"

import { initMap, addMarker } from "./editmaps"
window.initMap = initMap;
window.addMarker = addMarker;

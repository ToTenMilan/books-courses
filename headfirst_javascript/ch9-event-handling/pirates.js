window.onload = init;

function init() {
    var map = document.getElementById("map");
    map.onmousemove = showCoords;
    setTimeout(timerHandler, 5000);
}

function showCoords(eventObj) {
    var map = document.getElementById("coords");
    var x = eventObj.pageX;
    var y = eventObj.pageY;
    map.innerHTML = "Współrzędne na mapie: " + x + ", " + y;
}

function timerHandler() {
    alert("minęło 5 sekund");
}
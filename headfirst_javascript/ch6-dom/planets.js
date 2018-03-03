function init() {
    var planet = document.getElementById("greenplanet");
    planet.innerHTML = "ATAK! rozpoczynamy ostrzał z miotaczy kotków";
    planet.setAttribute("class", "redtext");
}

window.onload = init;
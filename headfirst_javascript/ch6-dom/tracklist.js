function addSongs() {
    var song1 = document.getElementById("song1");
    var song2 = document.getElementById("song2");
    var song3 = document.getElementById("song3");
    
    song1.innerHTML = "blue sueded shoes";
    song2.innerHTML = "ring of fire";
    song3.innerHTML = "first time of my life";
}

window.onload = addSongs;
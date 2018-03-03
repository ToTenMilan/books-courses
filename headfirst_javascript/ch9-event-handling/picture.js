function init() {
    var images = document.getElementsByTagName("img");
    for (var i = 0; i < images.length; i++) {
        images[i].onclick = showAnswer;
        // images[i].onmouseover = showAnswer;
        // images[i].onmouseout = reblur;
    }
}

function showAnswer(eventObj) {
    var image = eventObj.target;
    image.src = image.id + ".jpg";
    setTimeout(reblur, 3000, image);
    
}

// onclick version
function reblur(image) {
    image.src = image.id + "blur.jpg";
}

// onmouseover version
// function reblur(eventObj) {
//     var image = eventObj.target;
//     image.src = image.id + "blur.jpg";
// }

window.onload = init;
// window.onload = function() {
//     var button = document.getElementById("button");
//     var output = document.getElementById("message");
//     button.onclick = countClicks();
// }

// function countClicks() {
//     var count = 0;
    
//     function counter() {
//         count++;
//         return count;
//     }
//     return counter;
// }

window.onload = function() {
    var count = 0;
    var message = "You clicked me ";
    var div = document.getElementById("message");
    
    var button = document.getElementById("button");
    button.onclick = function() {
        count++;
        div.innerHTML = message + count + " times";
    };
};
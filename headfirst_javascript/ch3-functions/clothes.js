// exercise from p.116
function whatShallIWear(temp) {
    if (temp < 15) {
        console.log("ubierz kurtke");
    } else if (temp < 25) {
        console.log("Ubierz sweter");
    } else {
        console.log("Ubierz tshirt");
    }
}

whatShallIWear(15);
whatShallIWear(30);
whatShallIWear(10);
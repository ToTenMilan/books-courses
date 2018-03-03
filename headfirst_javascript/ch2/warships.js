var randomLoc = Math.floor(Math.random() * 5);
var location1 = randomLoc;
var location2 = randomLoc + 1;
var location3 = randomLoc + 2;
var guess;
var hits = 0;
var guesses = 0;
var isSunk = false;

while (isSunk == false) {
    guess = prompt("Strzel w pole od 0 do 6: ");
    if ( guess < 0 || guess > 6 ) {
        alert("To nie jest liczba z przedziału 0-7");
    } else {
        guesses += 1;
        if (guess == location1 || guess == location2 || guess == location3) {
            alert("trafiony");
            hits += 1;
            if (hits == 3) {
                isSunk = true;
                alert("zatopiłeś mój okręt");
            }
        } else {
            alert("pudło")
        }
    }
}

alert("oddałeś " + guesses + " strzałów");
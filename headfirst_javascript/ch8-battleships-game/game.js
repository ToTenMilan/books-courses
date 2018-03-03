var view = {
    displayMessage: function(msg) {
        var messageArea = document.getElementById("messageArea");
        messageArea.innerHTML = msg;
    },
    displayHit: function(location) {
        var cell = document.getElementById(location);
        cell.setAttribute("class", "hit");
    },
    displayMiss: function(location) {
        var cell = document.getElementById(location);
        cell.setAttribute("class", "miss");
    }
}

var model = {
    boardSize: 7,
    numShips: 3,
    shipLength: 3,
    shipsSunk: 0,
    
    ships: [{ locations: [0, 0, 0], hits: ["", "", ""] },
            { locations: [0, 0, 0], hits: ["", "", ""] },
            { locations: [0, 0, 0], hits: ["", "", ""] }],
            
    fire: function(guess) {
        for (var i = 0; i < this.numShips; i++) {
            var ship = this.ships[i];
            var index = ship.locations.indexOf(guess);
            if (index >= 0) {
                ship.hits[index] = "hit";
                view.displayHit(guess);
                view.displayMessage("Trafiony")
                if (this.isSunk(ship)) {
                    this.shipsSunk++;
                    view.displayMessage("Zatopiłeś okret");
                }
                return true;
            }
        }
        view.displayMiss(guess);
        view.displayMessage("Pudło");
        return false;
    },
    
    isSunk: function(ship) {
        for (var i = 0; i < this.shipLength; i++) {
            if (ship.hits[i] !== "hit") {
                return false
            }
        }
        return true;
    },
    
    generateShipLocations: function() {
        var locations;
        for (var i = 0; i < this.numShips; i++) {
            do {
                locations = this.generateShip();
            } while (this.collision(locations));
            this.ships[i].locations = locations;
        }
    },
    
    generateShip: function() {
        var direction = Math.floor(Math.random() * 2);
        var row, col;
        if (direction === 1) { // W poziomie.
			row = Math.floor(Math.random() * this.boardSize);
			col = Math.floor(Math.random() * (this.boardSize - this.shipLength));
		} else { // W pionie.
			row = Math.floor(Math.random() * (this.boardSize - this.shipLength));
			col = Math.floor(Math.random() * this.boardSize);
		}
        
        var newShipLocations = [];
        for (var i = 0; i < this.shipLength; i++) {
            if (direction === 1) {
                newShipLocations.push(row + "" + (col + i));
            } else {
                newShipLocations.push((row + i) + "" + col);
            }
        }
        return newShipLocations;
    },
    
    collision: function(locations) {
        for (var i = 0; i < this.numShips; i++) {
            var ship = model.ships[i];
            for (var j = 0; j < locations.length; j++) {
                if (ship.locations.indexOf(locations[j]) >= 0) {
                    return true;
                }
            }
        }
        return false;
    }
};

var controller = {
    guesses: 0,
    processGuess: function(guess) {
        var location = this.parseGuess(guess);
        if (location) {
            this.guesses++;
            var hit = model.fire(location);
            if ( hit && model.shipsSunk === model.numShips ) {
                view.displayMessage("Zatopiłeś wszystkie okręty w " + this.guesses + " próbach.");
            }
        }
    },
    
    parseGuess: function(guess) {
        var letters = ["A", "B", "C", "D", "E", "F", "G"];
        if (guess === null || guess.length !== 2) {
            alert("Proszę wpisać literę i cyfrę");
        } else {
            var firstChar = guess.charAt(0);
            var row = letters.indexOf(firstChar);
            var column = guess.charAt(1);
            
            if (isNaN(row) || isNaN(column)) {
                alert("To nie są współrzędne");
            } else if ( row < 0 || row >= model.boardSize || column < 0 || column >= model.boardSize) {
                alert("Pole poza planszą");
            } else {
                return row + column;
            }
        }
        return null;
    }
};

function init() {
    var fireButton = document.getElementById("fireButton");
    fireButton.onclick = handleFireButton;
    var guessInput = document.getElementById("guessInput");
    guessInput.onkeypress = handleKeyPress;
    
    model.generateShipLocations();
}

function handleFireButton() {
    var guessInput = document.getElementById("guessInput");
    var guess = guessInput.value;
    controller.processGuess(guess);
    
    guessInput.value = "";
}

function handleKeyPress(e) {
    var fireButton = document.getElementById("fireButton");
    if (e.keyCode === 13) {
        fireButton.click();
        return false;
    }
}

window.onload = init;


// view.displayMiss("00");
// view.displayHit("34");
// view.displayMessage("halo tu mesasage");

// model.fire("00");
// model.fire("06");
// model.fire("16");
// model.fire("26");

// controller.processGuess("A0"); // pudło

// controller.processGuess("A6"); // trafienie
// controller.processGuess("B6"); // trafienie
// controller.processGuess("C6"); // trafienie

// controller.processGuess("C4"); // trafienie
// controller.processGuess("D4"); // trafienie
// controller.processGuess("E4"); // trafienie

// controller.processGuess("B0"); // trafienie
// controller.processGuess("B1"); // trafienie
// controller.processGuess("B2"); // trafienie

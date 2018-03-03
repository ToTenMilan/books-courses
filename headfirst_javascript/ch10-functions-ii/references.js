function processPassengers(passengers, testFunction) {
    for (var i = 0; i < passengers.length; i++) {
        if (testFunction(passengers[i])) {
            return false;
        }
    }
    return true;
}

function checkNoFlyList(passenger) {
    return (passenger.name === "Dr Zatan");
}

function checkNotPaid(passenger) {
    return (!passenger.paid);
}


if (!allCanFly) {
    console.log("Ktos jest na liscie nie mogących latać");
}


if (!allPaid) {
    console.log("nie wszyscy kupili bilet");
}

function printPassenger(passenger) {
    if (passenger.paid) {
        console.log("pasażer " + passenger.name + " zapłacił za bilet");
    } else {
        console.log("pasażer " + passenger.name + " nie zapłacił za bilet");
    }
}

function createDrinkOrder(passenger) {
    var orderFunction;
    
    if (passenger.ticket === "pierwsza klasa") {
        orderFunction = function() {
            alert("Podać koktajl czy wino?");
        }
    } else if (passenger.ticket === "premium" ) {
        orderFunction = function() {
            alert("Podać cole wodzix czy wino")
        }
    } else {
        orderFunction = function() {
            alert("Podać cole czy wodzix?");
        }
    }
    return orderFunction;
}

function getDinnerFunction(passenger) {
    var orderFunction;
    
    if (passenger.ticket === "pierwsza klasa") {
        orderFunction = function() {
            alert("kurczak czy makaron?");
        }
    } else if (passenger.ticket === "premium" ) {
        orderFunction = function() {
            alert("Mięsny jeż czy talerz serów")
        }
    } else {
        orderFunction = function() {
            alert("suchy chleb z wczoraj czy herbatniki");
        }
    }
    return orderFunction;
}

function serveCustomer(passenger) {
    var getDrinkOrderFunction = createDrinkOrder(passenger);
    var getDinnerOrderFunction = getDinnerFunction(passenger);
    getDrinkOrderFunction();
    getDinnerOrderFunction();
    getDrinkOrderFunction();
    getDrinkOrderFunction();
}

function servePassengers(passengers) {
    for (var i = 0; i < passengers.length; i++ ) {
        serveCustomer(passengers[i]);
    }
}



var passengers = [ { name: "Danka Ptlicka", paid: true, ticket: "turystyczna" },
                    { name: "Dr Zatan", paid: true, ticket: "pierwsza klasa" },
                    { name: "Stefa Wciwa", paid: false, ticket: "pierwsza klasa"  },
                    { name: "Janek Funkcyjniak", paid: true, ticket: "premium"  } ];
var allCanFly = processPassengers(passengers, checkNoFlyList);
var allPaid = processPassengers(passengers, checkNotPaid);
var printedPassengers = processPassengers(passengers, printPassenger);
servePassengers(passengers);

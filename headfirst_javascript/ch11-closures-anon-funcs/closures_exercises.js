// Closure exercises

// ex. 1.
function makePassword(password) {
    return function(passwordGuess) {
        return (passwordGuess === password);
    };
}
var guessedPassword = makePassword("hello");
console.log(guessedPassword("hello"));

// ex. 2.
function multN(n) {
    return function(m) {
        return m * n;
    };
}

var multM = multN(2);
console.log(multM(3));

// ex. 3.
function makeCounter() {            // parameters to function are env too   // CLOSURE of counter()
    var count = 0;                  // environment of a function            // CLOSURE of counter()
    return function increment() {   // function                             // CLOSURE of counter()
        return ++count;             // function                             // CLOSURE of counter()
    };                              // function                             // CLOSURE of counter()
}
var doCount = makeCounter();
console.log(doCount());
console.log(doCount());
console.log(doCount());
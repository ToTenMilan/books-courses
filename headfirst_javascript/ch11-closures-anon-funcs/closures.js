// ############### not good for working in team because of possibility of overriding variables ##########
// var count = 0;

// function counter() {
//     count = count + 1;
//     return count;
// }

// ################## EXAMPLE OF CLOSURE #########
function makeCounter() {    // parameters to function are env too   // CLOSURE of counter()
    var count = 0;          // environment of a function            // CLOSURE of counter()
    function counter() {    // function                             // CLOSURE of counter()
        count++;            // function                             // CLOSURE of counter()
        return count;       // function                             // CLOSURE of counter()
    }                       // function                             // CLOSURE of counter()
    return counter;         // environment of a function            // CLOSURE of counter()
}

var doCount = makeCounter(); // save in doCount what makeCounter returns (reference to counter function in this case)

console.log(doCount()); // => 1 // call doCount() (counter function and its environment)
console.log(doCount()); // => 2 // call doCount() (counter function and its environment)
console.log(doCount()); // => 3 // call doCount() (counter function and its environment)
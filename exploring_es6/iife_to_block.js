let tmp = 2;


// ES5
(function() { // open IIFE
  tmp = 5;
}()); // close IIFE
console.log(tmp);


// ES6
{ // open block
  tmp = 5;
} // close block
console.log(tmp);
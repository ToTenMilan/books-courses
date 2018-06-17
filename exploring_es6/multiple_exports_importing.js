// ES5 importing
// var square = require('./multiple_exports').square
// var diag = require('./multiple_exports').diag
// or
// var square_diag = require('./multiple_exports');



// ES6 importing
import { square, diag } from 'multiple_exports'; // not supported up to node.js 9

console.log(square(11));
console.log(diag(4, 5));
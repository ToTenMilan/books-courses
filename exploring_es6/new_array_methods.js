const arr = ['a', NaN];

// ES5
arr.indexOf(NaN); // => -1
// ES6
arr.findIndex(x => Number.isNaN(x)); // 1


// ES5
var arr1 = Array.prototype.slice.call(arguments); // ???
// ES6
const arr2 = Array.from(arguments)

// ES5 examples
const arr3 = [...'abc'];
const arr4 = [...new Set().add('a').add('b')];

// console.log(arr1);
// console.log(arr2);
console.log(arr3);
console.log(arr4);
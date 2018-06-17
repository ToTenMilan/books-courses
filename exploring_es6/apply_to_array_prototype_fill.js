// ES5
var arr1 = Array.apply(null, new Array(2))
console.log(arr1); // => [ undefined, undefined ]

var arr2 = Array.apply(null, new Array(5))
console.log(arr2); // => [ undefined, undefined, undefined, undefined, undefined ]

// ES6
const arr3 = new Array(3).fill(undefined);
console.log(arr3)




// ES5
var arr4 = Array.apply(null, new Array(2))
    .map(function (x) { return 'x' });
console.log(arr4);


// ES6
const arr5 = new Array(4).fill('x')
console.log(arr5)
// ES5
// var arr1 = ['a', 'b'];
// var arr2 = ['c'];
// var arr3 = ['d', 'e'];

// console.log(arr1.concat(arr2, arr3));
// console.log(arr1);
// console.log(arr2);


// ES6
const arr1 = [1, 2];
const arr2 = ['c'];
const arr3 = ['d', 'e'];

console.log([...arr1, ...arr2, ...arr3])
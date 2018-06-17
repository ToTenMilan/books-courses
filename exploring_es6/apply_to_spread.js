// ES5
Math.max.apply(Math, [1,3,7,2,4,5]) // => 7

var arr1 = ['a', 'b'];
var arr2 = ['c', 'd'];

arr1.push.apply(arr1, arr2); // arr1 is now ['a', 'b', 'c', 'd']

// ES6
Math.max(...[1,3,7,2,4,5]) // => 7

const arr1 = ['a', 'b'];
const arr2 = ['c', 'd'];

arr1.push(...arr2); // arr1 is now ['a', 'b', 'c', 'd']
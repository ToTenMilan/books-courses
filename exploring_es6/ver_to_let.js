// var x = 3;

// function foo(randomize) {
//   if (randomize) {
//     var x = Math.random();
//     return x;
//   }
//   return x
// }

// console.log(foo(false)); // undefined
// console.log(foo(true)); // 0.925......


let x = 3;

function foo(randomize) {
  if (randomize) {
    let x = Math.random();
    return x;
  }
  return x
}

console.log(foo(false)); // 3
console.log(foo(true)); // 0.925......

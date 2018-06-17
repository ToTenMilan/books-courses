// ES5
// function logArgs() {
//   for (var i=0; i < arguments.length; i++) {
//     console.log(arguments[i]);
//   }
// }

// logArgs('yolo', 'wassup', true, NaN, undefined, String, Object, Math.random())
// ES6


function logArgs(...args) {
  for (const arg of args) {
    console.log(arg);
  }
}

logArgs('yolo', 'wassup', true, NaN, undefined, String, Object, Math.random())


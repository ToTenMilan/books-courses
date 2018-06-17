// ES5
// var yolo = {
//   foo: function(wassup) {
//     wassup = wassup || 'wtf?'
//     console.log('yolo')
//     console.log(wassup)
//   },
//   bar: function() {
//     return [this.foo(), this.foo];
//   }
// }

// yolo.foo()
// yolo.bar()[1]('wassup', yolo.bar()[1]('what a mess... dont code like this'));


// ES6
const yolo = {
  foo() {
    console.log('yolo')
  },
  bar() {
    return this.foo();
  }
}

yolo.bar()
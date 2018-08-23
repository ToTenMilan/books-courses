// // genarator
// function *createIterator(items) {
//     // for (let item of items) {
//     //     yield item;
//     // }
//     for (let i = 0; i < items.length; i++) {
//         yield items[i];
//     }
// }
//
// let iterator = createIterator([1,2,3])
// console.log(iterator.next());
// console.log(iterator.next());
// console.log(iterator.next());
// console.log(iterator.next());
// console.log(iterator.next());
// // In both cases (old for loop and for-of loop) result is
// // { value: 1, done: false }
// // { value: 2, done: false }
// // { value: 3, done: false }
// // { value: undefined, done: true }
// // { value: undefined, done: true }
//
//
//
// let createIterator2 = function *(items) {
//     // for (let item in items) {
//     //     yield item;
//     // }
//     for (let i = 0; i < items.length; i++) {
//         yield items[i];
//     }
// }
// let iterator2 = createIterator2([1,2,3]);
// console.log(iterator2.next());
// console.log(iterator2.next());
// console.log(iterator2.next());
// console.log(iterator2.next());
// console.log(iterator2.next());
// // using for-of loop the result is ( Values are coerced into strings)
// // { value: '0', done: false }
// // { value: '1', done: false }
// // { value: '2', done: false }
// // and the old way the result is
// // { value: 1, done: false }
// // { value: 2, done: false }
// // { value: 3, done: false }
// // { value: undefined, done: true }
// // { value: undefined, done: true }



// // object with generator as method
// let obj = {
//     createIterator: function *(items) {
//         for (let item of items) {
//             yield item;
//         }
//     }
// };
// // let iterator = obj.createIterator([1,2,3])
// // console.log(iterator.next());
// // console.log(iterator.next());
// // console.log(iterator.next());
// // console.log(iterator.next());



// let obj = {
//     *createIterator(items) {
//         for (let item of items) {
//             yield item;
//         }
//     }
// };
//
// let iterator = obj.createIterator([1,2,3])
// console.log(iterator.next());
// console.log(iterator.next());
// console.log(iterator.next());
// console.log(iterator.next());



// access to default iterator
// let vals = [1,2,3]
// let iterator = vals[Symbol.iterator]();
// console.log(iterator.next());
// console.log(iterator.next());
// console.log(iterator.next());
// console.log(iterator.next());



// is object iterable?
// function isIterable(object) {
//     return typeof object[Symbol.iterator] === "function";
// }
// console.log(isIterable([1,2,3]));
// console.log(isIterable('yolo'));
// console.log(isIterable(new Map()));
// console.log(isIterable(new Set()));
// console.log(isIterable(new WeakMap()));
// console.log(isIterable(new WeakSet()));



// creating iterable object
// let collection = {
//     items: [],
//     *[Symbol.iterator]() {
//         for (let item of this.items) {
//             yield item;
//         }
//     }
// };
// collection.items.push(1);
// collection.items.push(2);
// collection.items.push(3);
// for (let item of collection) {
//     console.log(item);
// }



// Destructuring Map ===================================
// let data = new Map();
// data.set("title", "yolo");
// data.set("price", 30);
// for (let [k, v] of data) {
//     console.log(`${k}: ${v}`);
// }



// var message = ['A ë–³ B']
// for (let i = 0; i < message.length; i++) {
//     console.log(message[i]);
// } // => A ë–³ B



// var message = [`A ${String.fromCharCode(123123123)} B`]
// var message = ['A ë–³ B']
// for (let c of message) {
//     console.log(c);
// }



// non array iterables ===========================================
// let set = new Set ([1,2,3,4,5,5,5,5,5]);
// console.log([...set])



// let map = new Map([["name", 'yolo'], ['age', 'yolt']]),
//     arr = [...map];
// console.log(arr);



// let nummies = [1,2,3],
//     nums = [100, 200, 300],
//     all = [0, ...nummies, ...nums];
// console.log(all.length, all);



// advanced iterators functionalaity ============================
// function *createIterator() {
//     let first = yield 1;
//     // console.log(`first ${first}`)
//     let second = yield first + 1;
//     // console.log(`first ${first}`)
//     // console.log(`sec ${second}`)
//     // // console.log('bef 3rd yld')
//     yield second + 1
//     // console.log(`third ${second}`)
//     // yield 'wassup'
//     // yield
// }
// let iterator = createIterator();
// console.log(iterator.next());
// console.log(iterator.next(3));
// console.log(iterator.next(5));
// console.log(iterator.next('whatehell?'));
// console.log(iterator.next('czupakabra'));
// console.log(iterator.next('wtf'));



// function *createIterator() {
//     let test = yield 1;
//     let test2 = yield test + 1;
//     // console.log(`first ${first}`)
//     // let second = yield first + 1;
//     // console.log(`first ${first}`)
//     // console.log(`sec ${second}`)
//     // // console.log('bef 3rd yld')
//     // yield second + 1
//     // console.log(`third ${second}`)
//     // yield 'wassup'
//     // yield
// }
// let iterator = createIterator();
// console.log(iterator.next());
// console.log(iterator.next());
// console.log(iterator.next());
// console.log(iterator.next('whatehell?'));
// // console.log(iterator.next('czupakabra'));
// // console.log(iterator.next('wtf'));



// raising error in iterator
// function *createIterator() {
//
//     let first = yield 1;
//     let second = yield first + 2;
//     yield second + 3;
// }
// let iterator = createIterator();
// console.log(iterator.next());
// console.log(iterator.next(4));
// console.log(iterator.throw(new Error("bang")));

// raise and catch error
// function *createIterator() {
//     let first = yield 1;
//     let second;
//     try {
//         second = yield first + 2;
//     } catch (ex) {
//         second = 6;
//     }
//     yield second + 3;
// }
// let iterator = createIterator();
// console.log(iterator.next());
// console.log(iterator.next(4));
// console.log(iterator.throw(new Error('bang')));
// console.log(iterator.next());



// return in generator
// function *createIterator() {
//     yield 1;
//     return;
//     yield 2;
//     yield 3;
// }
// let iter = createIterator();
// console.log(iter.next());
// console.log(iter.next());
// console.log(iter.next());
// console.log(iter.next());
// console.log(iter.next());



// function *createIterator() {
//     yield 1;
//     return 2;
// }
// let iterator = createIterator()
// console.log(iterator.next());
// console.log(iterator.next());
// console.log(iterator.next());
// console.log(iterator.next());
// console.log(iterator.next());



// delegate generator
// function *createIterator() {
//     yield 1;
//     yield 2;
// }
// function *createYoloIterator() {
//     yield 'yolo';
//     yield 'yoloyolo';
// }
// function *createWassupIterator() {
//     yield *createIterator();
//     yield *createYoloIterator();
//     yield true;
// }
// let iterator = createWassupIterator();
// console.log(iterator.next());
// console.log(iterator.next());
// console.log(iterator.next());
// console.log(iterator.next());
// console.log(iterator.next());
// console.log(iterator.next());



// function *createNumberIterator() {
//     yield 1;
//     yield 2;
//     return 3;
// }
// function *createRepeatingIterator(count) {
//     for (let i = 0; i < count; i++) {
//         yield `yolo ${count}`;
//     }
// }
// function *createCombinedIterator() {
//     let result = yield *createNumberIterator();
//     yield *createRepeatingIterator(result);
// }
// let iter = createCombinedIterator()
// console.log(iter.next());
// console.log(iter.next());
// console.log(iter.next());
// console.log(iter.next());
// console.log(iter.next());
// console.log(iter.next());



// function *createNumberIterator() {
//     yield 1;
//     yield 2;
//     return 3;
// }
// function *createRepeatingIterator(count) {
//     for (let i = 0; i < count; i++) {
//         yield `yolo ${count}`;
//     }
// }
// function *createCombinedIterator() {
//     let result = yield *createNumberIterator();
//     yield result;
//     yield *createRepeatingIterator(result);
//     yield "yolo";
//     yield new Error('Bang youre dead');
// }
// let iter = createCombinedIterator()
// console.log(iter.next());
// console.log(iter.next());
// console.log(iter.next());
// console.log(iter.next());
// console.log(iter.next());
// console.log(iter.next());
// console.log(iter.next());
// console.log(iter.next());
// console.log(iter.next());
// console.log(iter.next());



// asynchronious execute without yield
// let fs = require("fs");
// fs.readFile("config.json", function(err, contents) {
//   if (err) {
//     throw err;
//   }
//
//   doSomethingWith(contents);
//   console.log('Yolo');
// });



// asynchronious execute with yield
// function run(taskDef) {
//   let task = taskDef();
//   let result = task.next();
//   console.log('started');
//   function step() {
//     if (!result.done) {
//       result = task.next();
//       step();
//     }
//   }
//   step();
// };
//
// run(function*() {
//   console.log(1);
//   yield;
//   console.log(2);
//   yield;
//   console.log(3);
// });



// function run(taskDef) {
//   let task = taskDef();
//   let result = task.next();
//   console.log('started');
//   function step() {
//     if (!result.done) {
//       result = task.next(result.value);
//       step();
//     }
//   }
//   step();
// };
//
// run(function*() {
//   let value = yield 1;
//   console.log(value);
//   value = yield value + 3
//   console.log(value);
// });

// function fetchData() {
//   return function(callback) {
//     callback(null, 'yolo');
//   }
// }

// function fetchData() {
//   return function(callback) {
//     setTimeout(function() {
//       callback(null, 'yolo');
//     }, 200);
//   }
// }

function  run(taskDef) {
  let task = taskDef();
  let result = task.next();
  function step() {
    if (!result.done) {
      if (typeof result.value === "function") {
        result.value(function(err, data) {
          if (err) {
            result = task.throw(err);
            return;
          }
          result = task.next(data)
          step();
        });
      } else {
        result = task.next(result.value);
        step();
      }
    }
  }
  step()
}

let fs = require('fs');
function readFile(fileName) {
  return function(callback) {
    fs.readFile(fileName, callback);
  };
}

run(function*() {
  let contents = yield readFile("config.json");
  doSomethingWith(contents);
  console.log('yolo');
});

// ES5
var arr = ['a','b','c']
for (var i=0; i<arr.length; i++) {
  var elem = arr[i];
  console.log(elem);
}

arr.forEach(function (elem) {
  console.log(elem);
});


// ES6
const yolo = [1,2,3]
for (const elem of yolo) {
  console.log(elem)
}

for (const [index, elem] of arr.entries()) {
  console.log(index+ ', ' + elem);
}
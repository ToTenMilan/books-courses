// ES5
// function selectEntries(options) {
//   options = options || {};
//   var start = options.start || 0;
//   var end = options.end || -1;
//   var step = options.step || 1;
//   ···
// }


// ES6
function selectEntries({ start=0, end=-1, step=1 } = {}) {
    console.log(start, end, step);
}

selectEntries({
  start: 3
});
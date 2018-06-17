// ES5
function selectEntries(options) {
    var start = options.start || 0;
    var end = options.end || -1;
    var step = options.step || 1;
    // ...
}


// ES6
function selectEntries({ start = 0, end = -1, step = 1}) {
  // ...
}
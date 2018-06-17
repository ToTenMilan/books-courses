// ES5
if ('yolo'.indexOf('y') === 0) {}
// ES6
if ('yolo'.startsWith('y')) {} // ES6



// ES5
function endsWith(str, suffix) { 
    var index = str.indexOf(suffix);
    return index >= 0 && index === str.length - suffix.length;
}
console.log(endsWith('wassup', 'p')); // additionaly it do not serve words with last letter repeated i.e. 'yolo'
// ES6
console.log('yolo'.endsWith('o')); // ES6



// ES5
if (str.indexOf('x') >= 0) {}
// ES6
if (str.includes('x')) {} // ES6



// ES5
console.log(new Array(3+1).join('#'))
// ES6
console.log('#'.repeat(3))
// ES5
var obj = { foo: 123 };

var propDesc = Object.getOwnPropertyDescriptor(obj, 'foo');
var writable = propDesc.writable;
var configurable = propDesc.configurable;

console.log(writable, configurable);


// // ES6
const obj = { foo: 123 };
const {writable, configurable} = Object.getOwnPropertyDescriptor(obj, 'foo');

console.log(writable, configurable); // true true


function cl(text) {
  console.log(text);
}

// ES5
// function PersonType(name) {
//   this.name = name
// }
// PersonType.prototype.sayName = function() {
//   console.log(this.name)
// }
// var persona = new PersonType('zbych');
// persona.sayName();
// console.log(persona instanceof PersonType);
// console.log(persona instanceof Object);

// ES6
// class PersonClass {
//   constructor(name) {
//     this.name = name
//   }
//   sayName() {
//     console.log(this.name)
//   }
// }
// let person = new PersonClass('stach')
// person.sayName()
// cl(person instanceof PersonClass);
// cl(person instanceof Object);
// cl(typeof PersonClass);
// cl(typeof PersonClass.prototype.sayName);



// let PersonClass = class {
//   constructor(name) {
//     this.name = name
//   }
//   sayName() {
//     console.log(this.name)
//   }
// }
// let person = new PersonClass('stach')
// person.sayName()
// cl(person instanceof PersonClass);
// cl(person instanceof Object);
// cl(typeof PersonClass);
// cl(typeof PersonClass.prototype.sayName);



// let PersonClass = class PersonClass2 {
//   constructor(name) {
//     this.name = name
//   }
//   sayName() {
//     console.log(this.name)
//   }
// }
// cl(typeof PersonClass); // 'function'
// cl(typeof PersonClass2); // 'undefined'



// class as first-class citizen
// function createObject(classDef) {
//   return new classDef;
// }
// let obj = createObject(class {
//   sayHi() {
//     cl('yolo');
//   }
// });
// obj.sayHi();



// let person = new class {
//   constructor(name) {
//     this.name = name;
//   }
//   sayName() {
//     cl(this.name);
//   }
// }('zbychu');
// person.sayName();



// getter and setter
// class CustomHTMLElement {
//   constructor(element) {
//     this.element = element;
//   }
//   get html() {
//     return this.element.innerHTML;
//   }
//   set html(value) {
//     this.element.innerHTML = value;
//   }
// }
// var descriptor = Object.getOwnPropertyDescriptor(CustomHTMLElement.prototype, 'html');
// cl('set' in descriptor);
// cl('get' in descriptor);
// cl(descriptor.enumerable);



// generating method name
// let methodName = 'sayName';
// class PersonClass {
//   constructor(name) {
//     this.name = name;
//   }
//   [methodName]() {
//     cl(this.name);
//   }
// }
// let me = new PersonClass('zbych');
// me.sayName();



// generating property name
// let propertyName = 'html';
// class CustomHTMLElement {
//   constructor(element) {
//     this.element = element;
//   }
//   get [propertyName]() {
//     return this.element.innerHTML;
//   }
//   set [propertyName](value) {
//     this.element.innerHTML = value;
//   }
// }



// generator in class
// class GenClass {
//   *createIterator() {
//     yield 1;
//     yield 2;
//     yield 3;
//   }
// }
// let instance = new GenClass();
// let iterator = instance.createIterator();
// cl(iterator.next())
// cl(iterator.next())
// cl(iterator.next())
// cl(iterator.next())
//
//
//
// class Collection {
//   constructor() {
//     this.items = [];
//   }
//   *[Symbol.iterator]() {
//     yield *this.items.values();
//   }
// }
// var col = new Collection();
// col.items.push(1);
// col.items.push(2);
// col.items.push(3);
// for (let i of col) {
//   cl(i);
// }
//
// cl(col);
// cl(...col);



// static elements in ES5
function PersonType(name) {
  this.name = name;
}
PersonType.create = function(name) { // static method - Like Ruby class method
  return new PersonType(name);
}
PersonType.prototype.sayname = function() { // example method - like Ruby instance method
  cl(this.name);
}
var zbych = PersonType.create('zbych');
zbych.sayname()



// static elements in ES6
class PersonClass {
  constructor(name) {
    this.name = name;
  }
  sayName() { // like instance method in Ruby
    cl(this.name);
  }
  static create(name) { // like class method in Ruby
    return new PersonClass(name);
  }
}
let stach = PersonClass.create('stach');
stach.sayName();

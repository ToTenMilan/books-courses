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
// function PersonType(name) {
//   this.name = name;
// }
// PersonType.create = function(name) { // static method - Like Ruby class method
//   return new PersonType(name);
// }
// PersonType.prototype.sayname = function() { // example method - like Ruby instance method
//   cl(this.name);
// }
// var zbych = PersonType.create('zbych');
// zbych.sayname()



// // static elements in ES6
// class PersonClass {
//   constructor(name) {
//     this.name = name;
//   }
//   sayName() { // like instance method in Ruby
//     cl(this.name);
//   }
//   static create(name) { // like class method in Ruby
//     return new PersonClass(name);
//   }
// }
// let stach = PersonClass.create('stach');
// stach.sayName();



// ES5 inheritance
// function Rectangle(length, width) {
//   this.length = length;
//   this.width = width;
// }
// Rectangle.prototype.getArea = function() {
//   return this.length * this.width;
// }
// function Square(length) {
//   Rectangle.call(this, length, length);
// }
// Square.prototype = Object.create(Rectangle.prototype, {
//   constructor: {
//     // value: square,
//     enumerable: true,
//     writeable: true,
//     configurable: true
//   }
// });
// var square = new Square(4);
// cl(square.getArea());
// cl(square instanceof Square);
// cl(square instanceof Rectangle);

//ES6 inheritance
// class Rectangle {
//   constructor(length, width) {
//     this.length = length
//     this.width = width
//   }
//   getArea() {
//     return this.length * this.width
//   }
// }
// class Square extends Rectangle {
//   constructor(length) {
//     super(length, length)
//   }
// }
// var square = new Square(3)
// cl(square.getArea())
// cl(square instanceof Square)
// cl(square instanceof Rectangle)



// using 'constructor' keyword 'super()' must be present
// below classes are the same
// class Square extends Rectangle {
//   // 
// }
// class Square extends Rectangle {
//   constructor(...args) {
//     super(...args)
//   }
//   //
// }



// overriding methods
// class Square extends Rectangle {
//   constructor(length) {
//     super(length, length)
//   }
//   getArea() {
//     // return this.length * this.length
//     return super.getArea()
//   }
// }
// let square = new Square(5)
// cl(square.getArea())



// Inheriting static components
// class Rectangle {
//   constructor(length, width) {
//     this.length = length
//     this.width = width
//   }
//   getArea() {
//     return this.length * this.width
//   }
//   static create(length, width) { // similar to class method
//     return new Rectangle(length, width)
//   }
// }
// class Square extends Rectangle {
//   constructor(length) {
//     super(length, length)
//   }
// }
// let rect = Square.create(4, 5)
// cl(rect instanceof Rectangle) // => true
// cl(rect.getArea())
// cl(rect instanceof Square) // => false !!!



// inheriting after function/method
// function Rectangle(length, width) {
//   this.length = length
//   this.width = width
// }
// Rectangle.prototype.getArea = function() {
//   return this.length * this.width
// }
// function getbase() {
//   return Rectangle
// }
// class Square extends getbase() {
//   constructor(length) {
//     super(length, length)
//   }
// }
// var x = new Square(4)
// cl(x.getArea())
// cl(x instanceof Square)
// cl(x instanceof Rectangle)



// with dynamically inheriting after function we can do mixins (like Ruby modules)
// let SerializableMixin = {
//   serialize() {
//     return JSON.stringify(this)
//   }
// };
// let AreaMixin = {
//   getArea() {
//     return this.length * this.width
//   }
// }
// function mixin(...mixins) {
//   var base = function() {};
//   Object.assign(base.prototype, ...mixins) // use Object's method 'assign' to assign mixin objects to base.prototype
//   return base
// }
// class Square extends mixin(SerializableMixin, AreaMixin) {
//   constructor(length) {
//     super();
//     this.length = length;
//     this.width = length
//   }
// }
// var x = new Square(4)
// cl(x.getArea())
// cl(x.serialize())



// inheritinh after builin classes
// class MyArray extends Array {

// }
// var colors = new MyArray()
// colors[0] = 'blue'
// cl(colors.length)
// colors.length = 0
// cl(colors[0])
// let items = new MyArray(1, 2, 3, 4),
//     subitems = items.slice(1, 3)
// cl(items)
// cl(items instanceof MyArray) // true
// cl(subitems)
// cl(subitems instanceof MyArray) // true



// implementing inheriting after builtin classes
// class MyClass {
//   static get [Symbol.species]() {
//     return this;
//   }
//   constructor(value) {
//     this.value = value;
//   }
//   clone() {
//     return new this.constructor[Symbol.species](this.value);
//   }
// }
// let x = new MyClass(4)
// let y = x.clone()
// x.value = 5
// cl(y.value)
// cl(x.value)



// class DerivedClass1 extends MyClass {
//   // like Ruby class method 'def self.methodname'
// }
// class DerivedClass2 extends MyClass {
//   // like Ruby class method 'def MyClass.methodname'
//   static get [Symbol.species]() {
//     return MyClass
//   }
// }
// let x = new DerivedClass1("foo")
// clone1 = x.clone()
// let y = new DerivedClass2("bar")
// clone2 = y.clone()

// cl(clone1 instanceof MyClass)
// cl(clone1 instanceof DerivedClass1)
// cl(clone2 instanceof MyClass)
// cl(clone2 instanceof DerivedClass2)



// iverride Symbol.species to not use default class
// class MyArray extends Array {
//   static get [Symbol.species]() {
//     return Array
//   }
// }
// let items = new MyArray(1,2,3,4)
// let subitems = items.slice(1,3)
// cl(items instanceof MyArray)
// cl(subitems instanceof Array)
// cl(subitems instanceof MyArray)



// new.target
// class Rectangle {
//   constructor(length, width) {
//     cl(new.target === Rectangle) // true
//     this.length = length
//     this.width = width
//   }
// }
// // var obj = new Rectangle(3, 4)



// class Square extends Rectangle {
//   constructor() {
//     super(length, width)
//   }
// }
// var obj = new Square(3) // false



// Abstract base class
class Shape {
  constructor() {
    if (new.target === Shape) {
      throw new Error("You can not create example of abstract base class")
    }
  }
}
class Rectangle extends Shape {
  constructor(length, width) {
    super()
    this.length = length
    this.width = width
  }
}
// var x = new Shape
var y = new Rectangle(3,4)
cl(y instanceof Shape)
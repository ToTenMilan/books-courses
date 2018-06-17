// ES5
// function Person(name) {
//   this.name = name;
// }
// Person.prototype.describe = function() {
//   return 'Person called' + this.name;
// };


// ES6
class Person {
  constructor(name) {
    this.name = name;
  } // note no commas
  describe() {
    console.log('Person called ' + this.name)
  }
}

bob = new Person('bobsy bob');
// bob.name = 'bobsy man';
bob.describe()
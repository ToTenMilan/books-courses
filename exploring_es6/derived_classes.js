// ES5
// function Person(name) {
//     this.name = name;
// }
// Person.prototype.describe = function () {
//     return 'Person called '+this.name;
// };

// function Employee(name, title) {
//   Person.call(this, name); // super(name)
//   this.title = title
// }
// Employee.prototype = Object.create(Person.prototype);
// Employee.prototype.constructor = Employee;
// Employee.prototype.describe = function() {
//   return Person.prototype.describe.call(this) // super.describe()
//           + ' (' + this.title + ')';
// }


// ES6
class Person {
    constructor(name) {
        this.name = name;
    }
    describe() {
        return 'Person called '+this.name;
    }
}

class Employee extends Person {
  constructor(name, title) {
    super(name);
    this.title = title;
  }
  describe() {
    // return super.describe() + ' (' + this.title + ')';
    return `${super.describe()} (${this.title})`;
  }
}

em = new Employee('bobs', 'CEO')
console.log(em.describe())
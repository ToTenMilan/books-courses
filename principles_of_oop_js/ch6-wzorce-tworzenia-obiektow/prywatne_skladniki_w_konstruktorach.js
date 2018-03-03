function Person(name) {
    
    var age = 25;
    
    this.name = name;
    
    this.getAge = function() {
        return age;
    };
    
    this.growOlder = function() {
        age++;
    };
}
var person = new Person("Joe");

console.log(person.name);
console.log(person.getAge()); // => 25

person.age = 100;
console.log(person.getAge()); // => 25

person.growOlder();
console.log(person.getAge()); // => 26
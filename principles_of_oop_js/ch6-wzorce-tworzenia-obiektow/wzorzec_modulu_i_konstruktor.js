var Person = (function() {
    var sumOfApples = 25; // Ruby @@class_variable (?)
    
    function InnerPerson(name) {
        this.name = name;
    }
    
    InnerPerson.prototype.getSumOfApples = function() {
        return sumOfApples;
    };
    
    InnerPerson.prototype.addAppleToTotal = function() {
        sumOfApples++;
    };
    
    return InnerPerson;
}());

var bob = new Person("Bob");
var tim = new Person("Tim");

console.log(bob.name);
console.log(bob.getSumOfApples()); // => 25

console.log(tim.name);
console.log(tim.getSumOfApples()); // => 25

tim.addAppleToTotal();
console.log(tim.getSumOfApples()); // => 26
console.log(bob.getSumOfApples()); // => 26


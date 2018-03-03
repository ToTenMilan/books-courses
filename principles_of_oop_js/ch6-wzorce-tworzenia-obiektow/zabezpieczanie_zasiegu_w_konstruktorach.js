// how to prevent accidentally omited 'new' operator?

    /* ########## instead of this ##########
        function Person(name) {
            this.name = name;
        }
        
        var person = Person("Joe");         // omited 'new' operator
        console.log(person instanceof Person); // => false
        console.log(typeof person); // => undefined
        console.log(name); // => "Joe"
    */

// do this
function Person(name) {
    if (this instanceof Person) {
        this.name = name;
    } else {
        return new Person(name);
    }
}

var joe = Person("Joe");                    // omited 'new' operator
var bob = new Person("Bob");                // with 'new' operator
console.log(joe instanceof Person); // => true
console.log(bob instanceof Person); // => true


// wzorzec modułu (module pattern)
var person = (function() {
    
    var age = 25; // nie można się odwołać do `age` spoza obiektu (patrz linia 18 i 19)
    
    return {
        name: "Mike",
        getAge: function() {
            return age;
        },
        growOlder: function() {
            age++;
        }
    };
}()); // extra `()` znaczy funkcję natychmiastową

console.log(person.name);
console.log(person.getAge()); // => 25

person.age = 100;
console.log(person.getAge()); // => 25

person.growOlder();
console.log(person.getAge()); // => 26

// wzorzec modułu z ujawnianiem (revealing module pattern)
var person = (function() {
    
    var age = 25;
    
    function getAge() {
        return age;
    }
    
    function growOlder() {
        age++;
    }
    
    return {
        name: "Mike",
        getAge: getAge, // ujawnienie
        growOlder: growOlder // ujawnienie
    };
}());


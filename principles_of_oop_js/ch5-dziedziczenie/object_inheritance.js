// DZIEDZICZENIE OBIEKTÓW

// both variables below are equivalents
var book = {
    title: "Js book"
};

var book = Object.create(Object.prototype, {
    title: {
        configurable: true, // atrybut wspólny
        enumerable: true, // atrybut wspólny
        value: "Js book", // atrubyt właśćiwości danych
        writable: true // atrubyt właśćiwości danych
    }
});

// dziedzieczenie jednego obiektu po drugim
var mike = {
    name: "mike",
    sayName: function() {
        console.log("hello I am " + this.name);
    }
};

var mikeJunior = Object.create(mike, { // inherit after `mike`
    name: {
        enumerable: true,
        configurable: true,
        value: "Mike Junior",
        writable: true
    }
});

console.log(mike.hasOwnProperty("sayName"));
console.log(mike.isPrototypeOf(mikeJunior));
console.log(mikeJunior.hasOwnProperty("sayName"));
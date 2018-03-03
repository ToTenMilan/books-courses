var book = {
    title: "JS book"
};

var prototype = Object.getPrototypeOf(book);

console.log(prototype === Object.prototype);

// metoda valueOf()
var now = new Date();
var earlier = new Date(2010, 1, 1);
console.log(now > earlier);

// metoda toString()
var book = {
    title: "js book",
    toString: function() {
        return "[Książka " + this.title + "]"
    }
};

var msg = "book = " + book;

console.log(msg);

// modyfikowanie prototypu Object.prototype

Object.prototype.add = function(value) {
    return this + value;
};

    var empty = {}; // some object
    
    // wrong way
    for(var p in empty) {
        console.log(p);
    }; // => add
    
    // right way
    for (var p in empty) {
        if (empty.hasOwnProperty(p)) {
            console.log(p);
        }
    }


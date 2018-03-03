// DZIEDZICZENIE KONSTRUKTORÓW

function Rectangle(length, width) {
    this.length = length;
    this.width = width;
}

Rectangle.prototype.getArea = function() {
    return this.length * this.width;
};

Rectangle.prototype.toString = function() {
    return "[Rectangle " + this.width + "x" + this.length + "]";
};

function Square(size) {
    this.length = size;
    this.width = size;
}

Square.prototype = new Rectangle(); // inherit from Rectangle
Square.prototype.constructor = Square; // set constructor

    // equivalent to two lines above is the indented code below
    // Square.prototype = Object.create(Rectangle.prototype, {
    //     constructor: {
    //         configurable: true,
    //         enumerable: true,
    //         value: Square,
    //         writable: true
    //     }
    // });

Square.prototype.toString = function() { // override Rectangle.toString
    return "[Square " + this.width + "x" + this.length + "]";
};

var rect = new Rectangle(3, 4);
var sq = new Square(5);

console.log(rect.getArea());
console.log(sq.getArea());

console.log(rect.toString());
console.log(sq.toString());

console.log(rect instanceof Rectangle);
console.log(rect instanceof Object);

console.log(sq instanceof Square);
console.log(sq instanceof Rectangle);
console.log(sq instanceof Object);

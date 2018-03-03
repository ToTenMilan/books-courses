// domieszki (mixins)
function mixin(receiver, supplier) {
    for (var property in supplier) {
        if (supplier.hasOwnProperty(property)) {
            receiver[property] = supplier[property]
        }
    }
    return receiver;
}

// mixing instead of inheriting
// Create `EventTarget` type to mixin later to `Person` type
function EventTarget() {
    
}

EventTarget.prototype = {
    constructor: EventTarget,                               // prevent setting `Object` as constructor
    addListener: function(type, listener) {
        if (!this.hasOwnProperty("_listeners")) {           // if not present
            this._listeners = [];                           // create the empty private (as convention's '_*') `_listeners` array
        }
        
        if (typeof this._listeners[type] == "undefined") {
            this._listeners[type] = [];
        }
        
        this._listeners[type].push(listener);
    },
    
    fire: function(event) {
        if (!event.target) {
            event.target = this;
        }
        if (!event.type) {
            throw new Error("Obiekt zdarzenia nie ma właściwości 'type'.");
        }
        if (this._listeners && this._listeners[event.type] instanceof Array) {
            var listeners = this._listeners[event.type];
            for (var i = 0, len = listeners.length; i < len; i++) {
                listeners[i].call(this, event);
            }
        }
    },
    
    removeListener: function(type, listener){
        if (this._listeners && this._listeners[type] instanceof Array) {
            var listeners = this._listeners[type];
            for (var i=0, len=listeners.length; i<len; i++) {
                if (listeners[i] === listener) {
                    listeners.splice(i, 1);
                    break;
                }
            }
        }
    }
};

// working with EventTarget instance
var target = new EventTarget();
target.addListener("message", function(event) {
    console.log("Komunikat: " + event.data);
});

target.fire({
    type: "message",
    data: "Hello world!"
});

// handle event by different type objects

    /* ##### Including `EventTarget` in `Person` without mixing it (by inheriting) is bad ##### */
    /* ##### why `Person` type should inherit after `EventTarget`? ##### */

    /* ########## this is bad ##########
        var person = new EventTarget();                     // person object inherit (as an instance) after EventTarget
        person.name = "Mike";
        person.sayName = function() {
            console.log(this.name);
            this.fire({type: "namesaid", name: name});
        };
    */

    /* ########## this is bad ##########
    Person.prototype = Object.create(EventTarget.prototype);  // Person type inherit after EventTarget.prototype
    Person.prototype.constructor = Person;
    
    Person.prototype.sayName = function() {
        console.log(this.name);
        this.fire({ type: "namesaid", name: name });
    };
    
    var person = new Person("Mike");
    
    console.log(person instanceof Person);  // => true
    console.log(person instanceof EventTarget);  // => true (?)
    */
    
function Person(name) {
    this.name = name;
}

mixin(Person.prototype, new EventTarget());             // include `EventTarget` properties (methods in this case)
mixin(Person.prototype, {                               // include `constructor` and `sayName` properties in `Person`
    constructor: Person,                                // prevent setting `Object` as a constructor
    
    sayName: function() {
        console.log(this.name);
        this.fire({ type: "namesaid", name: name });
    }
});

var person = new Person("Mike");
console.log(person instanceof Person) // => true
console.log(person instanceof EventTarget); // => false

    /* ########## alternatively as suggested by book ##########
        var person = mixin(new EventTarget(), {
            name: "mike",
            sayName: function() {
                console.log(this.name);
                this.fire({ type: "namesaid", name: name });
            }
        });
        
        console.log(person instanceof EventTarget);     // => true
        console.log(person.sayName());                  // => "mike"
    */
    
    /* ##########  watchout for overriding properties ##########
        var person = mixin(new EventTarget(), {         // receiver: 'EventTarget', supplier: '{}'
            get name() {                                // only getter is defined so setting 'name' should not be possible
                return "Mike";
            },
            
            sayName: function() {
                console.log(this.name);
                this.fire({ type: "namesaid", name: name });
            }
            
        });
        
        console.log(person.name); // => "Mike"
        
        person.name = "Gary";                           // setting name despite not defining 'set' in properties
        console.log(person.name); // => "Gary"          // it is possible to set new value because 'name' becomes data property(właściwość danych) -> p. 118
    */
    
    /* ########## to prevent overriding properties (ECMAScript 5 and beyond) ##########
        function mixin(receiver, supplier) {
            Object.keys(supplier).forEach(function(property) {
                var descriptor = Object.getOwnPropertyDescriptor(supplier, property);
                Object.defineProperty(receiver, property, descriptor);
            });
            return receiver;
        }
        
        var person = mixin(new EventTarget(), {
            
            get name() {
                return "Mike";
            },
            
            sayName: function() {
                console.log(this.name);
                this.fire({ type: "namesaid", name: name });
            }
            
        });
        
        console.log(person.name); // => "Mike"
        
        person.name = "Greg";                                   // setting new value do not affect 'name'
        console.log(person.name); // => "Mike"
    */
    
    /* ########## to prevent overriding properties (before ECMAScript 5) ##########
        function mixin(receiver, supplier) {
            if (Object.getOwnPropertyDescriptor) {              // Checking if engine is ECMAScript 5
                Object.keys(supplier).forEach(function(property) {
                    var descriptor = Object.getOwnPropertyDescriptor(supplier, property);
                    Object.defineProperty(receiver, property, descriptor);
                });
            } else {                                            // if not execute the ECMAScript 3 code
                for (var property in supplier) {
                    if (supplier.hasOwnProperty(property)) {
                        receiver[property] = supplier[property];
                    }
                }
            }
            
            return receiver;
        }
    */


function validate(phoneNumber) {
    if (phoneNumber.length === 8 && phoneNumber.charAt(3) === "-") {
        var phoneNumber = phoneNumber.slice(0, 3) + phoneNumber.slice(4);
    }
    if (phoneNumber.length === 7 && !isNaN(phoneNumber)) {
        return true;
    }
    return false
}

        // using regex
        // function validate(phoneNumber) {
        //     return phoneNumber.match(/^\d{3}-?\d{4}$/);
        // }

var num1 = "123-4567";
var num2 = "1234567";
var num3 = "123456";
var num4 = "asd-1234";
var num5 = "12d-1234";
var num6 = "13r1234";
var num7 = "12345678";
var num8 = "123-45678";

console.log(validate(num1));
console.log(validate(num2));
console.log(validate(num3));
console.log(validate(num4));
console.log(validate(num5));
console.log(validate(num6));
console.log(validate(num7));
console.log(validate(num8));
var phrase = "Thats the phrase to test the string methods. It not meant meant to be funny"

console.log(phrase.length);

for (var i; i < phrase.length; i++) {
    if (phrase.charAt(i) === ".") {
        console.log("The end of phrase is at index " + i);
    }
}

var index = phrase.indexOf("string");
console.log("word 'string' starts at index no. " + index);

index = phrase.indexOf("th", 1);
console.log("the second occurency of 'th' substring is at index " + index);

index = phrase.indexOf("not present in phrase");
console.log("Not existing strings returns the index of " + index);

var substr = phrase.substring(0, 16);
console.log("first three words are: " + substr);

var substr2 = phrase.substring(16);
console.log("second argument is optional. Substring will count from first and in this case return: " + substr2);

var splitted = phrase.split(". ");
console.log("tablica z podzielonym zdaniem: ", splitted);


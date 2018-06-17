// ES5
// var dict = Object.create(null)
// function countWords(word) {
//     var escapeWord = escapeKey(word);
//     if (escapeWord in dict) {
//         return dict[escapeWord]++;
//     } else {
//         return dict[escapeWord] = 1;
//     }
// }
// function escapeKey(key) {
//     if (key.indexOf('__proto__') === 0) {
//         return key+'%';
//     } else {
//         return key;
//     }
// }

// countWords('yolo',1)
// countWords('wassup',2)
// countWords('man', 3)
// console.log(dict.length)

// ES6
const map = new Map();

function countWords(word) {
    const count = map.get(word) || 0;
    map.set(word, count + 1);
}

const str = 'yolo';
const num = 2;
const bool = true;

countWords(str, 'thats right');
countWords(num, 'times');
countWords(bool, 'how it is');
console.log(map.size);
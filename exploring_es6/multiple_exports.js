// CommonJS
// var sqrt = Math.sqrt;
// function square(x) {
//     return x * x;
// }
// function diag(x, y) {
//     return sqrt(square(x) + square(y));
// }
// module.exports = {
//     sqrt: sqrt,
//     square: square,
//     diag: diag,
// };


// ES6
export const sqrt = Math.sqrt;
export function square(x) {
    return x * x;
}
export function diag(x, y) {
    return sqrt(square(x) + (square(y));
}
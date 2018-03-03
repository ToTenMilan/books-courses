// chapter 4 exercises

var hasBubbleGum = [false, false, false, true];
var products = ["czulada", "mięta", "ciastko", "guma"];
var i = 0;

// while (i < hasBubbleGum.length) {
//     i += 1;
//     if (hasBubbleGum[i]) {
//         console.log(products[i] + " zawiera gumę do żucia");
//     }
// }

for (i = 0; i < hasBubbleGum.length; i++) {
    if (hasBubbleGum[i]) {
        console.log(products[i] + " zawiera gumę do żucia");
    }
}
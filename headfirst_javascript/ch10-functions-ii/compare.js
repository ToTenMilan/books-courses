var products = [ { name: "Grejpfrut", calories: 170, color: "czerwony", sold: 8200 },
{ name: "Pomara􀃱cza", calories: 160, color: "pomara􀃱czowy", sold: 12101 },
{ name: "Cola", calories: 210, color: "karmelowy", sold: 25412 },
{ name: "Cola dietetyczna", calories: 0, color: "karmelowy", sold: 43922 },
{ name: "Cytryna", calories: 200, color: "bezbarwny", sold: 14983 },
{ name: "Malina", calories: 180, color: "ró􀄝owy", sold: 9427 },
{ name: "Piwo korzenne", calories: 200, color: "karmelowy", sold: 9909 },
{ name: "Woda", calories: 0, color: "bezbarwny", sold: 62123 }
];

function compareSold(colaA, colaB) {
    if (colaA.sold > colaB.sold) {
        return 1;
    } else if (colaA.sold === colaB.sold) {
        return 0;
    } else {
        return -1;
    }
}
function compareName(colaA, colaB) {
    if (colaA.name > colaB.name) {
        return 1;
    } else if (colaA.name === colaB.name) {
        return 0;
    } else {
        return -1;
    }
}
function compareCalories(colaA, colaB) {
    if (colaA.calories > colaB.calories) {
        return 1;
    } else if (colaA.calories === colaB.calories) {
        return 0;
    } else {
        return -1;
    }
}
function compareColor(colaA, colaB) {
    if (colaA.color > colaB.color) {
        return 1;
    } else if (colaA.color === colaB.color) {
        return 0;
    } else {
        return -1;
    }
}

products.sort(compareName);
console.log("Produkty posortowane wed􀃯ug nazwy:");
printProducts(products);
products.sort(compareCalories);
console.log("Produkty posortowane wed􀃯ug liczby kalorii:");
printProducts(products);
products.sort(compareColor);
console.log("Produkty posortowane wed􀃯ug koloru:");
printProducts(products);

function printProducts(products) {
    for (var i = 0; i < products.length; i++) {
        console.log("Nazwa: " + products[i].name +
        ", liczba kalorii: " + products[i].calories +
        ", kolor: " + products[i].color +
        ", liczba sprzedanych butelek: " + products[i].sold);
    }
}

products.sort(compareSold)
console.log("Produkty posortowane według ilości sprzedanych butelek:");
printProducts(products);




// function compareNumbers(num1, num2, num3) {
//     console.log(num1);
//     console.log(num2);
//     console.log(num3);
//     if (num1 > num2) {
//         return 1;
//     } else if (num1 === num2) {
//         return 0;
//     } else {
//         return -1;
//     }
    
// }

// var numbers = [2,6,9,3];

// numbers.sort(compareNumbers);
// console.log(numbers);
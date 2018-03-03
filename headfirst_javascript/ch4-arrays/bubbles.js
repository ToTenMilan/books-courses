var scores = [60, 50, 60, 58, 54, 54,
              58, 50, 52, 54, 48, 69,
              34, 55, 51, 52, 44, 51,
              69, 64, 66, 55, 52, 61,
              46, 31, 57, 52, 44, 18,
              41, 53, 55, 61, 51, 44];
              
var costs = [.25, .27, .25, .25, .25, .25, .33, .31, 
            .25, .29, .27, .22, .31, .25, .25, .33, 
            .21, .25, .25, .25, .28, .25, .24, .22,
            .20, .25, .30, .25, .24, .25, .25, .25, 
	        .27, .25, .26, .29];

function printAndGetHighScore(scores) {
    var highScore = 0;
    var output;
    
    for (var i = 0; i < scores.length; i++) {
        output = "Płyn do baniek nr " + i + " wynik: " + scores[i];
        console.log(output);
        if (scores[i] > highScore) {
            highScore = scores[i];
        }
    }
    return highScore;
}

function getBestSolutions(scores, highScore) {
        /* ########## book version ##########
            for (i = 0; i < scores.length; i++) {
                if (scores[i] == highScore) {
                    bestSolutions.push(i);
                }
            }
        */
            
    // without push function
    var bestSolutions = [];
    var index = 0;
    for (var i = 0; i < scores.length; i++) {
        if (scores[i] == highScore) {
            bestSolutions[index++] = i;
            // index++;     // oneline longer but more readable
        }
    }
    return bestSolutions;
}

function getBestRate(scres, costs, highScore) {
    var cost = 100;
    var index;
    for (var i = 0; i <scores.length; i++) {
        if (scores[i] == highScore) {
            if (cost > costs[i]) {
                index = i;
                cost = costs[i];
            }
        }
    }
    return index;
}

        // function getCostsOfOneBubble(scores, costs) {
        //     var costsOfOneBubble = [];
        //     var cost;
        //     for (var i = 0; i < scores.length; i++) {
        //         cost = costs[i] / scores[i];
        //         costsOfOneBubble.push(cost);
        //     }
        //     return costsOfOneBubble;
        // }
        
        // function getLowestRate(costsOfOneBubble) {
        //     var lowestRate;
        //     for (var i = 0; i < scores.length; i++) {
        //         if (costsOfOneBubble[i] < lowestRate) {
        //             lowestRate = costsOfOneBubble[i];
        //         }
        //     }
        //     return lowestRate;
        // }

var highScore = printAndGetHighScore(scores);
var bestSolutions = getBestSolutions(scores, highScore);
        // var costsOfOneBubble = getCostsOfOneBubble(scores, costs);
var bestRate = getBestRate(scores, costs, highScore);

console.log("Liczba testów: " + scores.length);
console.log("Największa liczba wytworzonych baniek: " + highScore);
console.log("Najwyższe wyniki: " + bestSolutions);
        // console.log("Przeliczone koszty jednej bańki: " + costsOfOneBubble);
console.log("Najlepszy wskaźnik jest na pozycji: " + bestRate);

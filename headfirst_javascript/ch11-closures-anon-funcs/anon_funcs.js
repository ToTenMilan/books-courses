var cookies = {
    instructions: "Rozgrzewanie do 200 stopni",
    bake: function(time) {
        console.log("wypiekam");
        setTimeout(function() {
            alert("Ciasteczka sa gotowe, wyciągnij je, by przestygły.");
            console.log("Chłodzenie ciasteczek.");
            setTimeout(function() {
                alert("ciastka są ju zzimne");
            }, 1000);
        }, time);
    }
};

window.onload = function() {
    var button = document.getElementById("bake");
    button.onclick = function() {
        console.log("Juz można");
        cookies.bake(2500);
    };
};

// administer(patient, function(dosage) {
//     if (dosage > 0) {
//         inject(dosage);
//     }
// }, time);
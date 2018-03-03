var word = " butelek ";
var count = 99;
while (count >= 0) {
    console.log(count + word + "piwa na ścianie");
    console.log(count + word + "piwa,");
    console.log("Jedną weź i podaj w koło,");
    count -= 1;
    if (count > 0) {
        console.log(count + word + "piwa na ścianie.");
    } else {
        console.log("Nie ma już" + word + "piwa na ścianie.");
    }
}
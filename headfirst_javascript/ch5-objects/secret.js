// exercise from p.226
function getSecret(file, secretPassword) {
    file.opened += 1;
    if (secretPassword == file.password) {
        return file.contents;
    } else {
        return "Wrong password";
    }
}

function setSecret(file, secretPassword, secret) {
    if (secretPassword == file.password) {
        file.opened = 0;
        file.contents = secret;
    }
}

var superSecretFile = {
    level: "tajne",
    opened: 0,
    password: 2,
    contents: "Colonization of neptune is a fact"
};
var secret = getSecret(superSecretFile, 2);
console.log(secret);

setSecret(superSecretFile, 2, "Czechs and Slovaks want to colonize sun by night");
secret = getSecret(superSecretFile, 2);
console.log(secret);
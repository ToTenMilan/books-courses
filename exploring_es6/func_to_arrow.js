// ES5
function UiComponent() {
  var _this = this;
  var button = document.getElementById('myButton');
  button.addEventListener('click', function() {
    console.log('CLICK');
    _this.handleClick();
  });
}
UiComponent.prototype.handleClick = function () {
  console.log('been clicked');
}


//ES6
function UiComponent() {
  var button = document.getElementById('nyButton');
  button.addEventListener('click', () => {
    console.log('CLICK');
    this.handleClick();
  });
}




// ES5
var arr = [1, 2, 3];
var squares = arr.map(function (x) { return x * x });


// ES6
const arr = [1, 2, 3];
const squares = arr.map(x => x * x);
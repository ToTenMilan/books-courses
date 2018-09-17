function cl(text) {
  console.log(text);
}

// // creating array with consistnet behaviour
// function createArray(arrayCreator, value) {
// 	return arrayCreator(value)
// }
// let arr = createArray(Array.of, 4)
// cl(arr)



// // ES5 make Array of array-like objects
// function makeArray(arrayLike) {
// 	var result = []
// 	for (var i = 0, len = arrayLike.length; i < len; i++) {
// 		result.push(arrayLike[i])
// 	}
// 	return result
// }
// function doSomething() {
// 	var args = makeArray(arguments);
// 	// use args
// }
// // OR
// function makeArray(arrayLike) {
// 	return Array.prototype.slice.call(arrayLike) 
// }
// function doSomething() {
// 	var args = makeArray(arguments);
// 	// use args
// }



// // ES6 convert arraylike objects to Array
// function doSomething() {
// 	var args = Array.from(arguments)
// 	// use args
// }



// function adder() {
// 	return Array.from(arguments, (value) => value + 1);
// }
// let nums = adder(1,2,3)
// cl(nums)



// let helper = {
// 	diff: 1,
// 	add(value) {
// 		return value + this.diff;
// 	}
// }
// function adder() {
// 	return Array.from(arguments, helper.add, helper) // helper.add uses 'this', so we need to provide it in the third argument, 'helper' in this case
// }
// let nums = adder(1,2,3)
// cl(nums)



// Array.from in iterable elements
// let nums = {
// 	*[Symbol.iterator]() {
// 		yield 1;
// 		yield 2;
// 		yield 3;
// 	}
// }
// let nums2 = Array.from(nums, (value) => value + 1);
// cl(nums2)



// find() findIndex()
// let nums = [11,22,33,44,55]
// cl(nums.find(n => n > 40))
// cl(nums.findIndex(n => n > 40))



// fill
let nums = [1,2,3,4]
nums.fill('yolo')
cl(nums)
nums.fill('wassup', 2) // change value from index 2 included
cl(nums)
nums.fill('yeahboi', 1, 2) // change value from index 1 incl. to 2 excluded (so only at index 1)
cl(nums)
nums.fill('saywha?', -1) // from last index
cl(nums)
nums.fill('interesting', -2) // from penultimate index
cl(nums)
nums.fill('coolwhip', -2, 0)
cl(nums) // nothing at all
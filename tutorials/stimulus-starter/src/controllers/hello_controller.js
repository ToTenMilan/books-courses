import { Controller } from "stimulus"

export default class extends Controller {
  // connect() {} // is called every tme when controller connects to dom
  static targets = [ "name" ] // IMPORTANT! Must be `targers`
  
  greet() {
    // Example 1
    // const element = this.nameTarget // `this.nameTarget` returns first matching target element
    // const name = element.value
    // console.log(`Hello, ${name}`)

    // Example 2
    // Using getter `get name`
    console.log(`Hello, ${this.name}!`)

    // console.log('Hello, stimulus', this.element) // this.element is tag that has `data-controller`
  }

  yolo() {
    console.log("hello yolo")
  }

  get name() {
    return this.nameTarget.value
  }
}

// import { Controller } from "stimulus"

// export default class extends Controller {
//   static targets = [ "name" ]

//   greet() {
//     const element = this.nameTarget
//     const name = element.value
//     console.log(`Hello, ${name}!`)
//   }
// }


// Targets Map Important Elements To C
import {Controller} from 'stimulus'

export default class extends Controller {
  static targets = [ 'slide' ]

  initialize() {
    console.log(this.index)
    this.showCurrentSlide()
  }

  // get value from `data-slideshow-index`
  // initialize() {
  //   const index = parseInt(this.element.getAttribute("data-slideshow-index"))
  //   this.showSlide(index)
  // }
  /////// or shorter
  // initialize() {
  //   const index = parseInt(this.data.get("index"))
  //   this.showSlide(index)
  // }

  next() {
    // this.showSlide(this.index + 1)
    this.index++
  }

  previous() {
    this.index--
  }

  // showSlide(index) {
  //   this.index = index
  //   this.slideTargets.forEach((el, i) => {
  //     el.classList.toggle('slide--current', index == i)
  //   })
  // }

  showCurrentSlide() {
    this.slideTargets.forEach((el, i) => {
      el.classList.toggle('slide--current', this.index == i)
    })
  }

  get index() {
    return parseInt(this.data.get('index'))
  }

  set index(value) {
    this.data.set('index', value)
    this.showCurrentSlide()
  }
}
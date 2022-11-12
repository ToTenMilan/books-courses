class Vec {
  constructor(x, y) {
    this.x = x;
    this.y = y;
  }

  plus(vector) {
    const new_x = this.x + vector.x
    const new_y = this.y + vector.y
    return new Vec(new_x, new_y)
  }

  minus(vector) {
    const new_x = this.x - vector.x
    const new_y = this.y - vector.y
    return new Vec(new_x, new_y)
  }

  get length() {
    return Math.sqrt((this.x * this.x) + (this.y * this.y))
  }
}

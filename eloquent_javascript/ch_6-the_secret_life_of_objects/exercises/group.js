class Group {
  constructor(values = []) {
    this.group = values
  }

  add(value) {
    if (!this.has(value)) {
      this.group.push(value)
    }
  }

  delete(value) {
    if (this.has(value)) {
      const index = this.group.indexOf(value)
      this.group.splice(index, 1)
    }
  }

  has(value) {
    return this.group.indexOf(value) > -1
  }

  static from(iterable) { // static method is like class method in Ruby, method called on a class `Group` (in this case)
    const values = []
    for (const i of iterable) {
      values.push(i)
    }
    return new Group(values)
  }
}



let group = Group.from([10, 20]);
console.log(group.has(10));
console.log(group.has(30));
group.add(10);
group.delete(10);
console.log(group.has(10));

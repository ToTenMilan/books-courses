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

class GroupIterator {
  constructor(group) {
    this.position = 0
    this.group_object = group
  }

  next() {
    if (this.position == this.group_object.group.length) return { done: true }

    let value = this.group_object.group[this.position]
    this.position++
    return {value, done: false}
  }
}

Group.prototype[Symbol.iterator] = function() {
  return new GroupIterator(this);
};

for (let value of Group.from(["a", "b", "c"])) {
  console.log(value);
}

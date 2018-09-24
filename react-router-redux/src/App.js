import React, { Component } from 'react'
import classes from './App.css'
// import Radium, { StyleRoot } from 'radium'
import Person from './Person/Person';

class App extends Component {
  state = {
  	persons: [
  		{ id: '231', name: 'max', age: 23 },
  		{ id: 'dfgr', name: 'many', age: 24 },
      { id: 'dsdffgr', name: 'yolanta', age: 21 }
  	],
    showPersons: false
  }

  nameChangedHandler = (event, id) => {
    const personIndex = this.state.persons.findIndex(p => {
      return p.id === id
    })

    const person = {
      ...this.state.persons[personIndex]
    }
    // equivalent
    // const person = Object.assign({}, this.state.persons.findIndex(p => {
    //   return p.id === id
    // })

    person.name = event.target.value

    const persons = [...this.state.persons]
    persons[personIndex] = person

  	this.setState({ persons: persons })
  }

  deletePersonHandler = (personIndex) => {
    // always update the state after copying it (not modifying the reference)
    // const persons = this.state.persons         // persons is holding reference here
    // const persons = this.state.persons.slice() // slice is here to copy state.persons instead of refer it (via pointer)
    const persons = [...this.state.persons] // spread here is also copying state.persons instead of refering it
    persons.splice(personIndex, 1) // splice(takeThisElem, maxToTake)
    this.setState({ persons: persons })
  }

  togglePersonsHandler = () => {
    console.log('been clicked')
    const doesShow = this.state.showPersons
    this.setState({ showPersons: !doesShow })
  }

  render() {
    let persons = null
    let btnClass = null

    if (this.state.showPersons) {
      persons = (
        <div>
          {this.state.persons.map((person, index) => {
            return <Person
              click={() => this.deletePersonHandler(index)}
              name={person.name}
              age={person.age}
              key={person.id}
              changed={(event) => this.nameChangedHandler(event, person.id)} /> // key property is important for rendering faster. Assign for it some unique value i.e. 'id' 
          })}
        </div>
      )
      btnClass = classes.Red
    }

    const assignedClasses = []
    if (this.state.persons.length <= 2) {
      assignedClasses.push(classes.red)
    }
    if (this.state.persons.length <= 1) {
      assignedClasses.push(classes.bold)
    }

    return (
      // <StyleRoot>
      <div className={classes.App}>
        <h1>Hello React</h1>
        <p className={assignedClasses.join(' ')}>its alive</p>
        <button
          className={btnClass}
        	onClick={this.togglePersonsHandler}>Switch Name</button>
        {persons}
      </div>
      // </StyleRoot>
    )
  }
}

export default App

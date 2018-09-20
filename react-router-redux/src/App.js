import React, { Component } from 'react'
import './App.css'
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
  	const style = {
  		backgroundColor: 'light-blue',
  		font: 'inherit',
  		border: '1px solid blue',
  		padding: '8px',
  		cursor: 'pointer'
  	}

    let persons = null

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
    }

    return (
      <div className='App'>
        <h1>Hello React</h1>
        <p>its alive</p>
        <button
        	style={style}
        	onClick={this.togglePersonsHandler}>Switch Name</button>
        {persons}
      </div>
    )
  }
}

export default App

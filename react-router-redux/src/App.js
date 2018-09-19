import React, { Component } from 'react'
import './App.css'
import Person from './Person/Person';

class App extends Component {
  state = {
  	persons: [
  		{ name: 'max', age: 23 },
  		{ name: 'many', age: 24 }
  	]
  }

  switchNameHandler = (newName) => {
  	this.setState({ persons: [
  		{ name: newName, age: 13 },
  		{ name: 'mannYY', age: 14 }
  	] })
  }

  nameChangedHandler = (event) => {
  	this.setState({ persons: [
  		{ name: 'Max', age: 20 },
  		{ name: event.target.value, age: 18 }
  	] })
  }

  render() {
  	const style = {
  		backgroundColor: 'light-blue',
  		font: 'inherit',
  		border: '1px solid blue',
  		padding: '8px',
  		cursor: 'pointer'
  	};

    return (
      <div className='App'>
        <h1>Hello React</h1>
        <p>its alive</p>
        <button
        	style={style}
        	onClick={() => this.switchNameHandler('Max from anonymoys function')} >Switch Name</button>
        <Person
        	name={this.state.persons[0].name}
        	age={this.state.persons[0].age}/>
        <Person
        	name={this.state.persons[1].name}
        	age={this.state.persons[1].age}
        	click={this.switchNameHandler.bind(this, 'MAXI from Person.js')}
      		changed={this.nameChangedHandler}>
      			Hobbies: racing
      	</Person>
      </div>
    )
  }
}

export default App;

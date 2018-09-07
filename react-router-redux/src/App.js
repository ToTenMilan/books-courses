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

  switchNameHandler = () => {
  	this.setState({ persons: [
  		{ name: 'maxII', age: 13 },
  		{ name: 'mannYY', age: 14 }
  	]})
  }

  render() {
    return (
      <div className='App'>
        <h1>Hello React</h1>
        <p>its alive</p>
        <button onClick={this.switchNameHandler} >Switch Name</button>
        <Person name={this.state.persons[0].name} age={this.state.persons[0].age}/>
        <Person name={this.state.persons[1].name} age={this.state.persons[1].age}>Hobbies: racing</Person>
        
      </div>
    )
  }
}

export default App;

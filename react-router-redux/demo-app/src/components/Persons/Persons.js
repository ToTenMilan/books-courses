import React, { Component } from 'react'
import Person from './Person/Person'

// ============= FUNCTIONAL COMPONENT ==================
class Persons extends Component {
  constructor(props) {
    super()
    this.lastPersonRef = React.createRef()
    console.log('[Persons.js] constructor', props)
  }

  componentWillMount() {
    console.log('[Persons.js] compnentwillmount')
  }

  componentDidMount() {
    console.log('[Persons.js] componentDidMount')
    this.lastPersonRef.current.focus()
  }

  componentWillReceiveProps(nextProps) {
    console.log('[Persons.js] componentWillReceiveProps', nextProps)
  }

  // shouldComponentUpdate(nextProps, nextState) {
  //   console.log('[UPDATE Persons.js] shouldComponentUpdate', nextProps, nextState)
  //   return nextProps.persons !== this.props.persons ||
  //   nextProps.changed !== this.props.changed ||
  //   nextProps.clicked !== this.props.clicked
  //   // return true
  // }

  componentWillUpdate(nextProps, nextState) {
    console.log('[UPDATE Persons.js] componentWillUpdate', nextProps, nextState)
  }

  componentDidUpdate() {
    console.log('[UPDATE Persons.js] componentDidUpdate')
  }

  render() {
    console.log('[Persons.js] render')
    return this.props.persons.map((person, index) => {
      return <Person
        click={() => this.props.clicked(index)}
        position={index}
        name={person.name}
        age={person.age}
        key={person.id}
        ref={this.lastPersonRef}
        changed={(event) => this.props.changed(event, person.id)}
      />
    })
  }
}

export default Persons

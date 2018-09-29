import React, { Component } from 'react'
import classes from './App.css'
// import Radium, { StyleRoot } from 'radium'
import Persons from '../components/Persons/Persons'
import Cockpit from '../components/Cockpit/Cockpit'
import Aux from '../hoc/Aux'
import withClass from '../hoc/WithClass'

export const AuthContext = React.createContext(false)

// ============= STATEFUL COMPONENT ==================
class App extends Component {
  constructor(props) {
    super()
    console.log('[App.js] constructor', props)
  }

  componentWillMount() {
    console.log('[App.js] compnentwillmount')
  }

  componentDidMount() {
    console.log('[App.js] componentDidMount')
  }

  componentWillReceiveProps() {
    console.log('[App.js] componentWillReceiveProps')
  }

  // dont implement if extending PureComponent
  // shouldComponentUpdate(nextProps, nextState) {
  //   console.log('[UPDATE App.js] shouldComponentUpdate', nextProps, nextState)
  //   return nextState.persons !== this.state.persons ||
  //   nextState.showPersons !== this.state.showPersons
  // }

  componentWillUpdate(nextProps, nextState) {
    console.log('[UPDATE App.js] componentWillUpdate', nextProps, nextState)
  }

  componentDidUpdate() {
    console.log('[UPDATE App.js] componentDidUpdate')
  }

  static getDerivedStateFromProps(nextProps, prevState) {
    console.log('[UPDATE App.js] getDerivedStateFromProps', nextProps, prevState)
    return prevState
  }

  getSnapshotBeforeUpdate() {
    console.log('[UPDATE App.js] getSnapshotBeforeUpdate')
  }
  // ============== STATE ================
  state = {
    persons: [
      { id: '231', name: 'max', age: 23 },
      { id: 'dfgr', name: 'many', age: 24 },
      { id: 'dsdffgr', name: 'yolanta', age: 21 }
    ],
    showPersons: false,
    toggleClicked: 0,
    authenticated: false
  }

  // ============ BEHAVIOR ===============
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
    const doesShow = this.state.showPersons
    this.setState( (prevState, props) => {
      return {
        showPersons: !doesShow,
        toggleClicked: prevState.toggleClicked + 1
      }
    })
  }

  loginHandler = () => {
    this.setState({authenticated: true})
  }

  // ================ RENDERING =================
  render() {
    console.log('[App.js] render')
    let persons = null

    if (this.state.showPersons) {
      persons = (
        <Persons
          persons={this.state.persons}
          clicked={this.deletePersonHandler}
          changed={this.nameChangedHandler}
        />
      )
    }

    return (
      <Aux>
        <button onClick={() => {this.setState({showPersons: true})}}>Show Persons</button>
        <Cockpit
          appTitle={this.props.title}
          showPerson={this.state.showPersons}
          persons={this.state.persons}
          clicked={this.togglePersonsHandler}
          login={this.loginHandler}
        />
        <AuthContext.Provider value={this.state.authenticated}>
          {persons}
        </AuthContext.Provider>
      </Aux>
    )
  }
}

export default withClass(App, classes.App)

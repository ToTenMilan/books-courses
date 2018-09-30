import React from 'react'
import classes from './Cockpit.css'
import Aux from '../../hoc/Aux'

// ============= FUNCTIONAL COMPONENT ==================
const cockpit = (props) => {
  const assignedClasses = []
  let btnClass = classes.Button
  if (props.showPersons) {
    btnClass = [classes.Button, classes.Red].join(' ')
  }

  if (props.persons.length <= 2) {
    assignedClasses.push(classes.red)
  }
  if (props.persons.length <= 1) {
    assignedClasses.push(classes.bold)
  }

  return (
    <Aux>
      <h4>{ props.appTitle }</h4>
      <h1>Hello React</h1>
      <p className={assignedClasses.join(' ')}>its alive</p>
      <button
        className={btnClass}
        onClick={props.clicked}>
          Switch Name
      </button>
      <button onClick={props.login}>
        Log in
      </button>
    </Aux>
  )
}

export default cockpit

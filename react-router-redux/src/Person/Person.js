import React from 'react'
// import Radium from 'radium'

import classes from './Person.css'

const person = (props) => {
  // let rand = Math.random()
  // if (rand > 0.7) {
  //   throw new Error('Random error happened i.e. 504')
  // }

  return (
    <div className={classes.Person}>
      <p onClick={props.click}>yello, {props.name} here. I have {props.age} years old</p>
      <p>{props.children}</p>
      <input type='text' onChange={props.changed} value={props.name}/>
    </div>
  )
}

export default person

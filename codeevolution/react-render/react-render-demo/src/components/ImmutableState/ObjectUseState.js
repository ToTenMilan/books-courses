import React, { useState } from 'react'

const initState = {
  fname: 'Bruce',
  lname: 'Wayne',
}

export const ObjectUseState = () => {
  const [person, setPerson] = useState(initState)

  const changeName = () => {
    // dont modify directly
    // person.fname = 'Clark'
    // person.lname = 'Kent'
    // setPerson(person)

    // create a copy
    const newPerson = { ...person }
    newPerson.fname = 'Clark'
    newPerson.lname = 'Kent'
    setPerson(newPerson)
  }

  console.log('ObjectUseState Render')

  return (
    <div><button onClick={changeName}>{person.fname} {person.lname}</button></div>
  )
}

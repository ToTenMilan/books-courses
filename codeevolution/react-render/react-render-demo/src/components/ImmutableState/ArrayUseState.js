import React, { useState } from 'react'

const initState = ['Bruce', 'Wayne']

export const ArrayUseState = () => {
  const [persons, setPersons] = useState(initState)

  const handleClick = () => {
    // this wont work
    // persons.push('Clark')
    // persons.push('Kent')
    // setPersons(persons)

    // duplicate the array and then push
    const newPersons = [...persons]
    newPersons.push('Clark')
    newPersons.push('Kent')
    setPersons(newPersons)
  }

  console.log('ArrayUseState Render')

  return (
    <div>
      <button onClick={handleClick}>Click</button>
      {
        persons.map(person => {
          return <div key={person}>{person}</div>
        })
      }
    </div>
  )
}

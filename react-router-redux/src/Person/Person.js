import React from 'react';

const person = ( props ) => {
  return (
    <div>
      <p>yello, {props.name} here. I have {props.age} years old</p>
      <p>{props.children}</p>
    </div>
  )
}

export default person;

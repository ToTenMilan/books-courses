import React from 'react';

import './Person.css';

const person = (props) => (
    <div className="Person" onClick={props.clicked}>
        <h1>Name:{props.name}</h1>
        <p>Age: {props.age}</p>
    </div>
);

export default person;
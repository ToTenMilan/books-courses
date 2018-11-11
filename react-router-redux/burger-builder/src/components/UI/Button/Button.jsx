import React from 'react';

import classes from './Button.css'

const button = (props) => (
    <button
        // this button exposes:
        // btnType
        // clicked
        // so when using it we can do it like so:
        // <Button btnType="Danger" clicked={}

        disabled={props.disabled}
        className={[classes.Button, classes[props.btnType]].join(' ')}
        onClick={props.clicked}>

            {props.children}
    </button>
)
 
export default button;
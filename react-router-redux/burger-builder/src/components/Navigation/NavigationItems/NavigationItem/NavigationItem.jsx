import React from 'react';
import { NavLink } from 'react-router-dom' // use NavLink to style active link

import classes from './NavigationItem.css'

const navigationItem = (props) => {
    return (
        <li className={classes.NavigationItem} >
            <NavLink
                to={props.link}
                exact={props.exact}
                activeClassName={classes.active}>
                {props.children}
            </NavLink>
        </li>
    );
}
 
export default navigationItem;
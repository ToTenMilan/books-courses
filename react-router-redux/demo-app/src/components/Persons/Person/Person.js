import React, { Component } from 'react'
import PropTypes from 'prop-types'

import classes from './Person.css'
import Aux from '../../../hoc/Aux'
import withClass from '../../../hoc/WithClass'
import { AuthContext } from '../../../containers/App'

class Person extends Component {
  constructor(props) {
    super()
    this.inputElement = React.createRef()
    console.log('[Person.js] constructor', props)
  }

  componentWillMount() {
    console.log('[Person.js] compnentwillmount')
  }

  componentDidMount() {
    console.log('[Person.js] componentDidMount')
    if (this.props.position === 0) {
      this.inputElement.current.focus()
    }
  }

  focus() {
    this.inputElement.current.focus()
  }

  render() {
    console.log('[Person.js] render')
    return (
      <Aux>
        <AuthContext.Consumer>
          {auth => auth ? <p>I am authenticated</p> : <p>I am not authenticated :(</p>}
        </AuthContext.Consumer>
        <p onClick={this.props.click}>yello, {this.props.name} here. I have {this.props.age} years old</p>
        <p>{this.props.children}</p>
        <input
          ref={this.inputElement}
          type='text'
          onChange={this.props.changed}
          value={this.props.name}/>
      </Aux>
    )
    // Arrays can also be used but they need 'key' prop
    // return [
    //   <p key={1} onClick={this.props.click}>yello, {this.props.name} here. I have {this.props.age} years old</p>
    //   <p key={2}>{this.props.children}</p>
    //   <input key={3} type='text' onChange={this.props.changed} value={this.props.name}/>
    // ]
  }
}

Person.propTypes = {
  click: PropTypes.func,
  name: PropTypes.string,
  age: PropTypes.number,
  changed: PropTypes.func
}

export default withClass( Person, classes.Person )

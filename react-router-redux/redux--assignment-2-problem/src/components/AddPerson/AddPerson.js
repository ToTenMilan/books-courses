import React, { Component } from 'react';

import './AddPerson.css';

class addPerson extends Component {
    state = {
        name: '',
        age: ''
    }

    nameChangedHandler = (event) => {
        this.setState({ name: event.target.value });
    }

    ageChengedHandler = (event) => {
        this.setState({ age: event.target.value });
    }

    render() {
        return (
            <div className="AddPerson">
                <input
                    type="text"
                    placeholder="Name"
                    onChange={this.nameChangedHandler}
                    value={this.state.name} />
                <input
                    type="number"
                    placeholder="Age"
                    onChange={this.ageChengedHandler}
                    value={this.state.age} />
                    {/* below calls function as it is defined */}
                {/* <button onClick={this.props.personAdded}>Add Person</button> */}
                    {/* If we want to pass some e3xtra data we need to use anonymous function syntax */}
                <button onClick={() => this.props.personAdded(this.state.name, this.state.age)}>Add Person</button>
            </div>
        )
    }
}

export default addPerson;

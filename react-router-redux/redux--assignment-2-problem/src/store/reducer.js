import * as actionTypes from './actions'

const initialState = {
    persons: []
}

const personAddedHandler = () => {
    return {
        id: Math.random(), // not really unique but good enough here!
        name: 'Max',
        age: Math.floor( Math.random() * 40 )
    }
}

const reducer = (state = initialState, action) => {
    switch (action.type) {
        case actionTypes.ADD_PERSON:
            console.log('ADDING PERSON');
            return {
                ...state,
                persons: state.persons.concat(personAddedHandler())
            }
        case actionTypes.DELETE_PERSON:
            console.log('DELETING PEROSN');
            const updatedPersons = state.persons.filter(person => person.id !== action.personId)
            return {
                ...state,
                persons: updatedPersons
            }
    }
    return state
}

export default reducer;
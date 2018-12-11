import * as actionTypes from '../actions/actionTypes'
// REDUCER result
import { updateObject } from '../utility';

const initialState = {
    results: []
}

const reducer = (state = initialState, action) => {
    switch (action.type) {
        case actionTypes.STORE_RESULT:
            return updateObject(state, { results: state.results.concat({id: new Date(), value: action.result })})
        case actionTypes.DELETE_RESULT:
            // const id = 2
            // const newAray = [...state.results] // create a copy
            // newAray.splice(id, 1)
            const updatedArray = state.results.filter(result => result.id !== action.resultElementId); // returns new array
            return updateObject(state, {results: updatedArray})

    }
    return state
}

export default reducer

import * as actionTypes from './actions'

const initialState = {
    counter: 0,
    results: []
}

const reducer = (state = initialState, action) => {
    switch (action.type) {
        case actionTypes.INCREMENT:
            return {
                ...state, // create a copy of old state
                counter: state.counter + 1 // overwrite 'counter' key if it exists, add it if not exist
            }
        case actionTypes.DECREMENT:
            return {
                ...state,
                counter: state.counter - 1
            }
        case actionTypes.ADD:
            return {
                ...state,
                counter: state.counter + action.val
            }
        case actionTypes.SUBTRACT:
            return {
                ...state,
                counter: state.counter - action.val
            }
        case actionTypes.STORE_RESULT:
            return {
                ...state,
                results: state.results.concat({id: new Date(), value: state.counter})
            }
        case actionTypes.DELETE_RESULT:
            // const id = 2
            // const newAray = [...state.results] // create a copy
            // newAray.splice(id, 1)
            const updatedArray = state.results.filter(result => result.id !== action.resultElementId); // returns new array
            return {
                ...state,
                results: updatedArray
            }
    }
    return state
}

export default reducer

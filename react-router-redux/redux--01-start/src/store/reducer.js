const initialState = {
    counter: 0,
    results: []
}

const reducer = (state = initialState, action) => {
    switch (action.type) {
        case 'INCREMENT':
            return {
                ...state, // create a copy of old state
                counter: state.counter + 1 // overwrite 'counter' key if it exists, add it if not exist
            }
        case 'DECREMENT':
            return {
                ...state,
                counter: state.counter - 1
            }
        case 'ADD':
            return {
                ...state,
                counter: state.counter + action.val
            }
        case 'SUBTRACT':
            return {
                ...state,
                counter: state.counter - action.val
            }
        case 'STORE_RESULT':
            return {
                ...state,
                results: state.results.concat({id: new Date(), value: state.counter})
            }
        case 'DELETE_RESULT':
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

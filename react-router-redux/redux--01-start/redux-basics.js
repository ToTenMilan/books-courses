const redux = require('redux')
const createStore = redux.createStore;

const initialState = {
    counter: 0
}

// Reducer
const rootReducer = (state=initialState, action) => {
    if (action.type === 'INC_COUNTER') {
        return {
            ...state,
            counter: state.counter + 1
        }
    }
    if (action.type === 'ADD_COUNTER') {
        return {
            ...state,
            counter: state.counter + action.value
        }
    }
    return state
}

// Store
const store = createStore(rootReducer)
console.log(store.getState());

// Subscription - subscribe to this store
store.subscribe(() => {
    console.log('[Subscription]', store.getState())
})

// Dispatching Action
store.dispatch({type: 'INC_COUNTER'}); // inclrement counter and notify subscribents (call subscribe() )
store.dispatch({type: 'ADD_COUNTER', value: 10}); // add 10 to counter and notify subscribents (call subscribe() )
console.log(store.getState());

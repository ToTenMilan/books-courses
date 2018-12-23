import * as actionTypes from '../actions/actionTypes'
import { updateObject } from '../utility';

const initialState = {
    ingredients: null,
    totalPrice: 4,
    error: false
}

const INGREDIENT_PRICES = {
    salad: 0.2,
    cheese: 0.4,
    meat: 0.9,
    bacon: 0.5
}

const reducer = (state = initialState, action) => {
    switch (action.type){
        case actionTypes.ADD_INGREDIENT:
            const updatedIngredient = { [action.ingredientName]: state.ingredients[action.ingredientName] + 1 } 
            const updatedIngredients = updateObject(state.ingredients, updatedIngredient);
            const updatedState = {
                ingredients: updatedIngredients,
                totalPrice: state.totalPrice + INGREDIENT_PRICES[action.ingredientName]
            }
            return updatedState
        case actionTypes.REMOVE_INGREDIENT:
            const updatedRemovedIngredient = { [action.ingredientName]: state.ingredients[action.ingredientName] - 1 } 
            const updatedRemovedIngredients = updateObject(state.ingredients, updatedRemovedIngredient);
            const updatedRemovedState = {
                ingredients: updatedRemovedIngredients,
                totalPrice: state.totalPrice + INGREDIENT_PRICES[action.ingredientName]
            }
            return updatedRemovedState
        case actionTypes.SET_INGREDIENTS:
            return updateObject( state, {
                ingredients: action.ingredients,
                totalPrice: 4,
                error: false
            })
        case actionTypes.FETCH_INGREDIENTS_FAILED:
            return updateObject( state, {
                error: true
            })
        default:
            return state
    }
}

export default reducer;
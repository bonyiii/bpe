import { combineReducers } from 'redux'

const ids = (state = [], action) => {
  switch(action.type) {
  case 'FETCH_BPESTATES_SUCCESS':
    return action.response.result
  case 'ADD_BPESTATE_SUCCESS':
    return [...state, action.response.result]
  case 'DELETE_BPESTATE_SUCCESS':
    return state.filter((item) => item != action.id)
  default:
    return state
  }
}

const byId = (state = {}, action) => {
  if (action.response) {
    return {
        ...state,
        ...action.response.entities.states
    }
  }
  // http://stackoverflow.com/questions/35342355/remove-data-from-nested-objects-without-mutating
  if (action.type == 'DELETE_BPESTATE_SUCCESS' && action.id) {
    let copy = Object.assign({}, state) // assuming you use Object.assign() polyfill!
    delete copy[action.id] // shallowly mutating a shallow copy is fine
    return copy

    //let { [action.index]: deletedItem, ...rest } = state
    //return rest
  }
  return state
}

const bpeStates = combineReducers({
  ids,
  byId
})

export default bpeStates

export const getBpeState = (state, id) => state[id]

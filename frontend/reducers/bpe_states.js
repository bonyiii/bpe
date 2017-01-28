import { combineReducers } from 'redux'

const ids = (state = [], action) => {
  switch(action.type) {
  case 'FETCH_BPESTATES_SUCCESS':
    return action.response.result
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
  return state
}

const bpeStates = combineReducers({
  ids,
  byId
})

export default bpeStates

export const getBpeState = (state, id) => state[id]

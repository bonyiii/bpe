import { combineReducers } from 'redux'

const ids = (state = [], action) => {
  switch(action.type) {
  case 'FETCH_CURRENT_USER_SUCCESS':
    return action.response.result
  default:
    return state
  }
}

const byId = (state = {}, action) => {
  if (action.response) {
    return {
        ...state,
        ...action.response.entities.users
    }
  }
  return state
}

const users = combineReducers({
  ids,
  byId
})

export default users

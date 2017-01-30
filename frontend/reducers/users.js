import { combineReducers } from 'redux'

const currentUser = (state = {}, action) => {
  switch(action.type) {
  case 'FETCH_CURRENT_USER_SUCCESS':
    return action.currentUser
  default:
    return state
  }
}

export default currentUser

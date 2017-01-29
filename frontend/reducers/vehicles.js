import { combineReducers } from 'redux'

const ids = (state = [], action) => {
  switch(action.type) {
  case 'FETCH_VEHICLE_SUCCESS':
    return action.response.result
  case 'ADD_VEHICLE_SUCCESS':
    return [...state, action.response.result]
  case 'DELETE_VEHICLE_SUCCESS':
    return state.filter((item) => item != action.id)
  default:
    return state
  }
}

const byId = (state = {}, action) => {
  if (action.response) {
    return {
        ...state,
        ...action.response.entities.vehicles
    }
  }
  if (action.type == 'DELETE_VEHICLE_SUCCESS' && action.id) {
    let copy = Object.assign({}, state) // assuming you use Object.assign() polyfill!
    delete copy[action.id] // shallowly mutating a shallow copy is fine
    return copy
  }
  return state
}

const vehicles = combineReducers({
  ids,
  byId
})

export default vehicles

export const getVehicle = (state, id) => state[id]

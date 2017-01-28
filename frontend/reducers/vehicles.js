import { combineReducers } from 'redux'

const ids = (state = [], action) => {
  switch(action.type) {
  case 'FETCH_VEHICLE_SUCCESS':
    return action.response.result
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
  return state
}

const vehicles = combineReducers({
  ids,
  byId
})

export default vehicles

export const getVehicle = (state, id) => state[id]

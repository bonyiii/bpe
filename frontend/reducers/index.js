import { combineReducers } from 'redux'
import bpeStates, { getBpeState } from './bpe_states'
import vehicles, { getVehicle } from './vehicles'
import currentUser from './users'

const bpeReducer = combineReducers({
  bpeStates,
  vehicles,
  currentUser
})

export default bpeReducer

export const getBpeStates = (state) => {
  const ids = state.bpeStates.ids
  return ids.map((id) => getBpeState(state.bpeStates.byId, id))
}

export const getVehicles = (state) => {
  const ids = state.vehicles.ids
  return ids.map((id) => getBpeState(state.vehicles.byId, id))
}

export const getCurrentUser = (state) => {
  return state.currentUser
}

import { combineReducers } from 'redux'
import bpeStates, { getBpeState } from './bpe_states'
import vehicles, { getVehicle } from './vehicles'
import users from './users'

const bpeReducer = combineReducers({
  bpeStates,
  vehicles,
  users
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
  const id = state.users.ids
  return state.users.byId[id]
}

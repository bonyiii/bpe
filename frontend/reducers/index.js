import { combineReducers } from 'redux'
import bpeStates, { getBpeState } from './bpe_states'
import vehicles, { getVehicle } from './vehicles'

const bpeReducer = combineReducers({
  bpeStates,
  vehicles
})

export default bpeReducer

export const getBpeStates = (state) => {
  const ids = state.ids
  return ids.map((id) => {
    return getBpeState(state.byId, id)
  })
}

export const getVehicles = (state) => {
  const ids = state.ids
  return ids.map((id) => getBpeState(state.byId, id))
}

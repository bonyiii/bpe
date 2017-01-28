import { combineReducers } from 'redux'
import bpeStates, { getBpeState } from './bpe_states'

const bpeReducer = combineReducers({
  bpeStates
})

export default bpeReducer

export const getBpeStates = (state) => {
  const ids = state.ids
  return ids.map((id) => {
    return getBpeState(state.byId, id)
  })
}

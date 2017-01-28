import { combineReducers } from 'redux'
import { bpeStateIds, bpeStateById, getBpeState } from './bpe_states'

const bpeReducer = combineReducers({
  bpeStateIds,
  bpeStateById
})

export default bpeReducer

export const getBpeStates = (state) => {
  const ids = state.bpeStateIds
  return ids.map((id) => {
    return getBpeState(state.bpeStateById, id)
  })
}

import { connect } from 'react-redux'

import { bpeStateSelect } from './bpe_state_select.jsx'
import BpeStateSelect from './bpe_state_select.jsx'
import { updateBpeState, deleteBpeState } from '../actions'

let BpeState = ({
  id,
  name,
  from_state,
  bpeStates,
  dispatch
}) => {
  let input
  let select

  return(
    <tr>
      <td>
        <input
            defaultValue={name}
            ref={ node => input = node }
        />
      </td>
      <td>
        {' <- '}
        <select ref={ node => { select = node } }
                defaultValue={!!from_state && from_state.id}
        >
          <option></option>
          {
            bpeStates.map(
              state =>
                <option
                    key={state.id}
                    value={state.id}
                >
                  {state.name}
                </option>
            )
          }
        </select>
      </td>
      <td>
        <button
            onClick={() => {
                dispatch(updateBpeState({
                  id,
                  name: input.value,
                  from_state_id: select.value
                }))
              }}
        >Update</button>
        <button
            onClick={() => {
                dispatch(deleteBpeState(id))
              }}
        >
          Delete
        </button>
      </td>
    </tr>
  )
}
BpeState = connect()(BpeState)
export default BpeState

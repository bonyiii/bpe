import { connect } from 'react-redux'

import { bpeStateSelect } from './bpe_state_select.jsx'
import BpeStateSelect from './bpe_state_select.jsx'
import { deleteBpeState } from '../actions'

let BpeState = ({
  id,
  name,
  from_state,
  bpeStates,
  dispatch
}) => {
  return(
    <tr>
      <td>
        {name}
      </td>
      <td>
        {' <- '}
        <BpeStateSelect
            bpeStates={bpeStates}
            selected={!!from_state && from_state.id}
        />
        <button>Update</button>
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

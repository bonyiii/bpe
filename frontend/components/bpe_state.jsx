import { connect } from 'react-redux'

import { updateBpeState, deleteBpeState, upBpeState, downBpeState } from '../actions'

let BpeState = ({
  id,
  name,
  from_state,
  bpeStates,
  currentUser,
  dispatch
}) => {
  let input
  let select

  return(
    <tr>
      <td>
        <button
            onClick={ () => dispatch(upBpeState(id)) }
        >
          Up
        </button>
        <button
            onClick={ () => dispatch(downBpeState(id)) }
        >
          Down
        </button>
      </td>
      <td>
        {
          currentUser.is_admin ?
          <input
              defaultValue={name}
              ref={ node => input = node }
          /> :
          name
        }
      </td>
      <td>
        {' <- '}
        {
          (!!from_state && from_state.name)
        }
      </td>
      {
        currentUser.is_admin ?
        <td>
          <button
              onClick={() => {
                  dispatch(updateBpeState({
                    id,
                    name: input.value
                  }))
                }}
          >Update
          </button>
          <button
              onClick={() => {
                  dispatch(deleteBpeState(id))
                }}
          >
            Delete
          </button>
        </td> :
        <td></td>
      }
    </tr>
  )
}
BpeState = connect()(BpeState)
export default BpeState

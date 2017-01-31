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
          currentUser.is_admin ?
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
          </select> :
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
                    name: input.value,
                    from_state_id: select.value
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

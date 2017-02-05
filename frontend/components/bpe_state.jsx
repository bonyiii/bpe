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
        <div className="row">
          <div className="column medium-6">

            <i className="fi-arrow-up"
               onClick={ () => dispatch(upBpeState(id)) }
            >
            </i>
          </div>
          <div className="column medium-6">
            <i className="fi-arrow-down"
               onClick={ () => dispatch(downBpeState(id)) }
            >
            </i>
          </div>
        </div>
      </td>
      <td>
        {
          currentUser.is_admin ?
          <input
              type="text"
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
          <div className="row">
            <div className="column medium-6">
              <button
                  onClick={() => {
                      dispatch(updateBpeState({
                        id,
                        name: input.value
                      }))
                    }}
                  className="button"
              >Update
              </button>
            </div>
            <div className="column medium-6">
              <button
                  onClick={() => {
                      dispatch(deleteBpeState(id))
                    }}
                  className="alert button"
              >
                Delete
              </button>
            </div>
          </div>
        </td> :
        <td></td>

      }
    </tr>
  )
}
BpeState = connect()(BpeState)
export default BpeState

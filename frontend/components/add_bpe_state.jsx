import { connect } from 'react-redux'
import { addBpeState } from '../actions'

let AddBpeState = ({
  bpeStates,
  dispatch
}) => {
  let input
  let select

  return (
    <div className="row">
      <div className="column medium-5">
        <label>
          <input
              ref={ node => {
                  input = node
                }}
              type="text"
              placeholder="Add new state"
              onKeyPress={ (e) => {
                  if (e.key === "Enter") {
                    dispatch(addBpeState({
                      name: input.value,
                      from_state_id: select.value
                    }))
                    input.value = ""
                  }
                }}
          />
        </label>
      </div>
      <div className="column medium-4">
        <label>
          <select ref={ node => { select = node } }>
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
        </label>
      </div>
      <div className="column medium-3">
        <button
            onClick={ () => {
                dispatch(addBpeState({
                  name: input.value,
                  from_state_id: select.value
                }))
                input.value = ""
              }}
            className="button"
        >
          Add State
        </button>
      </div>
    </div>
  )
}

AddBpeState = connect()(AddBpeState)

export default AddBpeState

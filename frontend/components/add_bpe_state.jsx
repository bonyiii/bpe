import { connect } from 'react-redux'
import { addBpeState } from '../actions'

let AddBpeState = ({
  bpeStates,
  dispatch
}) => {
  let input
  let select

  return (
    <div>
      <input
          ref={ node => {
              input = node
            }}
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
      <select ref={ node => { select = node } }>
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
      <button onClick={ () => {
          dispatch(addBpeState({
            name: input.value,
            from_state_id: select.value
          }))
          input.value = ""
        }}>
        Add State
      </button>
    </div>
  )
}

AddBpeState = connect()(AddBpeState)

export default AddBpeState

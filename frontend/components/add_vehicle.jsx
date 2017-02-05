import { connect } from 'react-redux'
import { addVehicle } from '../actions'

let AddVehicle = ({ dispatch }) => {
  let input

  return (
    <div className="row">
      <div className="column medium-9">
        <label>
          <input
              ref={ node => {
                  input = node
                }}
              type="text"
              placeholder="Add new vehicle"
              onKeyPress={ (e) => {
                  if (e.key === "Enter") {
                    dispatch(addVehicle(input.value))
                    input.value = ""
                  }
                }}
          />
        </label>
      </div>
      <div className="column medium-3">
        <button
            onClick={ () => {
                dispatch(addVehicle(input.value))
                input.value = ""
              }}
            className="button"
        >
          Add Vehicle
        </button>
      </div>
    </div>
  )
}

AddVehicle = connect()(AddVehicle)

export default AddVehicle

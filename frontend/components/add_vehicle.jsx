import { connect } from 'react-redux'
import { addVehicle } from '../actions'

let AddVehicle = ({ dispatch }) => {
  let input

  return (
    <div>
      <input
          ref={ node => {
              input = node
            }}
          onKeyPress={ (e) => {
              if (e.key === "Enter") {
                dispatch(addVehicle(input.value))
                input.value = ""
              }
            }}
      />
      <button onClick={ () => {
          dispatch(addVehicle(input.value))
          input.value = ""
        }}>
        Add Vehicle
      </button>
    </div>
  )
}

AddVehicle = connect()(AddVehicle)

export default AddVehicle

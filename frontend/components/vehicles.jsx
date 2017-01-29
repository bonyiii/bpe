import { Component } from 'react'
import { connect } from 'react-redux'
import { withRouter } from 'react-router'

import * as actions from '../actions'
import { getVehicles } from '../reducers'
import AddVehicle from './add_vehicle.jsx'
import Vehicle from './vehicle.jsx'

class Vehicles extends Component {
  componentDidMount() {
    this.fetchData()
  }

  componentDidUpdate(prevProps) {
    //    this.fetchData()
  }

  fetchData() {
    const { fetchVehicles } = this.props
    fetchVehicles().then(response => console.log(response, "fetch vehicles done!"))
  }

  render() {
    const { vehicles, toNextState, deleteVehicle } = this.props
    // console.log(Vehicles)
    return(
      <div>
        <AddVehicle/>
        <table>
          <thead>
            <tr>
              <th>Name</th>
              <th>State</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {vehicles.map( vehicle =>
              <Vehicle
                  key={vehicle.id}
                  onToNextStateClick={() => toNextState(vehicle.id)}
                  deleteVehicle={() => deleteVehicle(vehicle.id)}
                  {...vehicle}
              />
             )}
          </tbody>
        </table>
      </div>
    )
  }
}

const mapStateToProps = (state, { params }) => {
  return {
    vehicles: getVehicles(state.vehicles)
  }
}

Vehicles = withRouter(connect(
  mapStateToProps,
  actions
)(Vehicles))

export default Vehicles

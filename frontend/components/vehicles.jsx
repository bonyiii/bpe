import { Component } from 'react'
import { connect } from 'react-redux'
import { withRouter } from 'react-router'

import * as actions from '../actions'
import { getVehicles } from '../reducers'
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
    const { vehicles } = this.props
    // console.log(Vehicles)
    return(
      <ul>
        {vehicles.map( state =>
          <Vehicle
              key={state.id}
              {...state}
          />
         )}
      </ul>
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

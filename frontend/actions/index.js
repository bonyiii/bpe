import { normalize } from 'normalizr'
import * as schema from './schema'
import * as api from '../lib/api'

export const fetchBpeStates = () => (dispatch, getState) => {
  dispatch({
    type: 'FETCH_BPESTATES_REQUEST'
  })

  return api.fetchBpeStates().then(
    response => {
      dispatch({
        type: 'FETCH_BPESTATES_SUCCESS',
        response: normalize(response['states'], schema.stateArray)
      })
    },
    error => {
      dispatch({
        type: 'FETCH_BPESTATES_FAILURE',
        message: error.message || 'Something went wrong.'
      })
    }
  )
}

export const fetchVehicles = () => (dispatch, getState) => {
  dispatch({
    type: 'FETCH_VEHICLE_REQUEST'
  })

  return api.fetchVehicles().then(
    response => {
      dispatch({
        type: 'FETCH_VEHICLE_SUCCESS',
        response: normalize(response['vehicles'], schema.vehicleArray)
      })
    },
    error => {
      dispatch({
        type: 'FETCH_VEHICLE_FAILURE',
        message: error.message || 'Something went wrong.'
      })
    }
  )
}

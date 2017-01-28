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

export const toNextState = (id) => (dispatch, getState) => {
  dispatch({
    type: 'NEXT_STATE_REQUEST'
  })

  return api.toNextState(id).then(
    response => {
      dispatch({
        type: 'NEXT_STATE_SUCCESS',
        response: normalize(response['vehicle'], schema.vehicleEntity)
      })
    },
    error => {
      dispatch({
        type: 'NEXT_STATE_FAILURE',
        message: error.message || 'Something went wrong.'
      })
    }
  )
}

export const addVehicle = (name) => (dispatch, getState) => {
  dispatch({
    type: 'ADD_VEHICLE_REQUEST'
  })

  return api.addVehicle(name).then(
    response => {
      dispatch({
        type: 'ADD_VEHICLE_SUCCESS',
        response: normalize(response['vehicle'], schema.vehicleEntity)
      })
    },
    error => {
      dispatch({
        type: 'ADD_VEHICLE_FAILURE',
        message: error.message || 'Something went wrong.'
      })
    }
  )
}

import { normalize } from 'normalizr'
import * as schema from './schema'
import * as api from '../lib/api'

const handleError = (error, dispatch, type) => {
  error => {
    dispatch({
      type: type,
      message: error.message || 'Something went wrong.'
    })
  }
}

export const fetchCurrentUser = () => (dispatch, getState) => {
  dispatch({
    type: 'FETCH_CURRENT_USER_REQUEST'
  })

  return api.fetchCurrentUser().then(
    response => {
      dispatch({
        type: 'FETCH_CURRENT_USER_SUCCESS',
        currentUser: response['user']
      })
    },
    error => handleError(error, dispatch, 'FETCH_CURRENT_USER_FAILURE')
  )
}

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
    error => handleError(error, dispatch, 'FETCH_BPESTATES_FAILURE')
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
    error => handleError(error, dispatch, 'FETCH_VEHICLE_FAILURE')
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
    error => handleError(error, dispatch, 'NEXT_STATE_FAILURE')
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
    error => handleError(error, dispatch, 'ADD_VEHICLE_FAILURE')
  )
}

export const deleteVehicle = (id) => (dispatch, getState) => {
  dispatch({
    type: 'DELETE_VEHICLE_REQUEST'
  })

  return api.deleteVehicle(id).then(
    response => {
      dispatch({
        type: 'DELETE_VEHICLE_SUCCESS',
        id
      })
    },
    error => handleError(error, dispatch, 'DELETE_VEHICLE_FAILURE')
  )
}


export const addBpeState = (changeset) => (dispatch, getState) => {
  dispatch({
    type: 'ADD_BPESTATE_REQUEST'
  })

  return api.addBpeState(changeset).then(
    response => {
      dispatch({
        type: 'ADD_BPESTATE_SUCCESS',
        response: normalize(response['state'], schema.stateEntity)
      })
    },
    error => handleError(error, dispatch, 'ADD_BPESTATE_FAILURE')
  )
}

export const updateBpeState = (changeset) => (dispatch, getState) => {
  dispatch({
    type: 'UPDATE_BPESTATE_REQUEST'
  })

  return api.updateBpeState(changeset).then(
    response => {
      dispatch({
        type: 'UPDATE_BPESTATE_SUCCESS',
        response: normalize(response['state'], schema.stateEntity)
      })
    },
    error => handleError(error, dispatch, 'UPDATE_BPESTATE_FAILURE')
  )
}


export const deleteBpeState = (id) => (dispatch, getState) => {
  dispatch({
    type: 'DELETE_BPESTATE_REQUEST'
  })

  return api.deleteBpeState(id).then(
    response => {
      dispatch({
        type: 'DELETE_BPESTATE_SUCCESS',
        id
      })
    },
    error => handleError(error, dispatch, 'DELETE_BPESTATE_FAILURE')
  )
}

export const upBpeState = (id) => (dispatch, getState) => {
  dispatch({
    type: 'UP_BPESTATE_REQUEST'
  })

  return api.upBpeState(id).then(
    response => {
      dispatch({
        type: 'UP_BPESTATE_SUCCESS',
        response: normalize(response['states'], schema.stateArray)
      })
    },
    error => handleError(error, dispatch, 'UP_BPESTATE_FAILURE')
  )
}

export const downBpeState = (id) => (dispatch, getState) => {
  dispatch({
    type: 'DOWN_BPESTATE_REQUEST'
  })

  return api.downBpeState(id).then(
    response => {
      dispatch({
        type: 'DOWN_BPESTATE_SUCCESS',
        response: normalize(response['states'], schema.stateArray)
      })
    },
    error => handleError(error, dispatch, 'DOWN_BPESTATE_FAILURE')
  )
}

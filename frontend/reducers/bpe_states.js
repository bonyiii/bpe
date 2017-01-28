export const bpeStateIds = (state = [], action) => {
  switch(action.type) {
  case 'FETCH_BPESTATES_SUCCESS':
    return action.response.result
  default:
    return state
  }
}

export const bpeStateById = (state = {}, action) => {
  if (action.response) {
    return {
        ...state,
        ...action.response.entities.states
    }
  }
  return state
}

export const getBpeState = (state, id) => state[id]

export const fetchBpeStates = () => (
  jQuery.get('/api/v1/states')
)

export const fetchVehicles = () => (
  jQuery.get('/api/v1/vehicles')
)

export const toNextState = (id) => (
  jQuery.ajax({
    url: `/api/v1/vehicles/${id}/next_state`,
    type: 'PUT'
  })
)

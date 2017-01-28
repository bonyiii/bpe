export const fetchBpeStates = (filter) => (
  jQuery.get('/api/v1/states')
)

export const fetchVehicles = (filter) => (
  jQuery.get('/api/v1/vehicles')
)

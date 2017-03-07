export const login = (formData) => (
  jQuery.post('/api/login', formData)
)

export const fetchCurrentUser = () => (
  jQuery.get('/api/v1/users')
)

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

export const addVehicle = (name) => (
  jQuery.post('/api/v1/vehicles', { name: name})
)

export const deleteVehicle = (id) => (
  jQuery.ajax({
    url: `/api/v1/vehicles/${id}`,
    type: 'DELETE'
  })
)

export const addBpeState = (changeset) => (
  jQuery.post('/api/v1/states', changeset)
)

export const updateBpeState = (changeset) => (
  jQuery.ajax({
    url: `/api/v1/states/${changeset.id}`,
    type: 'PUT',
    data: changeset
  })
)

export const deleteBpeState = (id) => (
  jQuery.ajax({
    url: `/api/v1/states/${id}`,
    type: 'DELETE'
  })
)

export const upBpeState = (id) => (
  jQuery.ajax({
    url: `/api/v1/states/${id}/up`,
    type: 'PUT',
  })
)

export const downBpeState = (id) => (
  jQuery.ajax({
    url: `/api/v1/states/${id}/down`,
    type: 'PUT',
  })
)

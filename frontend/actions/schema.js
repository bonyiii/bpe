import { normalize, schema} from 'normalizr'

export const stateEntity = new schema.Entity('states')
export const stateArray = new schema.Array(stateEntity)

export const vehicleEntity = new schema.Entity('vehicles')
export const vehicleArray = new schema.Array(vehicleEntity)

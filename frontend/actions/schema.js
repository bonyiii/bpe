import { normalize, schema} from 'normalizr'

export const stateEntity = new schema.Entity('states')
export const stateArray = new schema.Array(stateEntity)
export const stateObject = new schema.Object({ states: stateArray })

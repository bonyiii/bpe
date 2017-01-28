import { createStore, applyMiddleware } from 'redux'
import createLogger from 'redux-logger'
import thunk from 'redux-thunk'
import bpeReducer from '../reducers'
import { composeWithDevTools } from 'redux-devtools-extension'

const configureStore = () => {
  const middlewares = [thunk]

  if (process.env.NODE_ENV !== 'production') {
    middlewares.push(createLogger())

    return createStore(
      bpeReducer,
      composeWithDevTools(
        applyMiddleware(...middlewares)
      )
    )
  } else {
    return createStore(
      bpeReducer,
      applyMiddleware(...middlewares)
    )
  }
}

export default configureStore

import { Link } from 'react-router'
import { connect } from 'react-redux'
import { login } from '../actions'

let Login = ({
  dispatch
}) => {
  let formData = {
    email: null,
    password: null
  }

  return (
    <div>
      <label>
        <input type="text" placeholder="email" ref={ node => {
            formData.email = node
          }} />
      </label>
      <label>
        <input type="password" placeholder="password" ref={ node => {
            formData.password = node
          }} />
      </label>
      <button onClick={ () => {
          dispatch(login({
            email: formData.email.value,
            password: formData.password.value
          }))
        }}
      >Login</button>
    </div>
  )
}

Login = connect()(Login)

export default Login

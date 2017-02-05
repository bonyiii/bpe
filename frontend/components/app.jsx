import { Link } from 'react-router'

const ACTIVE = { color: 'red' }

const App = ({
  children
}) => (
  <div className="panel">
    <div className="row header align-center">
      <div className="column medium-7">
        <ul className="tabs text-center">
          <li className="tabs-title">
            <Link to='/states' activeStyle={ACTIVE}>States</Link>
          </li>
          <li className="tabs-title">
            <Link to='/vehicles' activeStyle={ACTIVE}> Vehicles </Link>
          </li>
        </ul>
      </div>
    </div>

    <div className="row content align-center">
      <div className="column medium-7">
        {children}
      </div>
    </div>
  </div>
)

export default App

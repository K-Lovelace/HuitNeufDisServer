const { Container, Row, Col } = Reactstrap;
class Supervisor extends React.Component {
  constructor(props) {
    super(props)
    this.loadDetails = this.loadDetails.bind(this);
    this.handleChange = this.handleChange.bind(this);
    this.state = {
      user: null
    }
  }

  loadDetails(e, user) {
    this.setState({
      user: user
    })
  }

  handleChange(e) {
    let user = this.state.user
    user[e.target.name] = e.target.value;
    this.setState({
      user: user
    })
    this.updateUser(user)
  }

  updateUser(user) {
    let url = user.url;
    return $.ajax({
      url: url,
      method: 'PUT',
      data: {user: user}
    })
  }

  render() {
    return (
      <Container>
        <Row>
          <Col><h1>Bienvenue</h1></Col>
        </Row>

        <Row>
          <Col xs="3">
            <AllUsers loadDetails={this.loadDetails}/>
          </Col>
          <Col id="right-pane">
            <UserForm user={this.state.user} handleChange={this.handleChange}/>
          </Col>
        </Row>
      </Container>
    )
  }
}

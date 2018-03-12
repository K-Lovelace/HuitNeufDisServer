const { Button, Form, FormGroup, Label, Input, FormText } = Reactstrap
class UserForm extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    if(this.props.user === null)
      return(<h1>Cliquez sur un utilisateur à gauche pour voir ses détails</h1>)
    return (
      <Form>
        <FormGroup>
          <Label for="name">Nom</Label>
          <Input type="text" name="name" id="name" value={this.props.user.name}  onChange={this.props.handleChange}/>
        </FormGroup>
        <FormGroup row>
          <Col>
            <FormGroup>
              <Label for="max_push">Charge maximale de poussée</Label>
              <Input type="number" name="max_push" id="max_push" value={this.props.user.max_push} onChange={this.props.handleChange}/>
            </FormGroup>
          </Col>
          <Col>
            <FormGroup>
              <Label for="max_carry">Charge maximale soulevée</Label>
              <Input type="number" name="max_carry" id="max_carry" value={this.props.user.max_carry} onChange={this.props.handleChange}/>
            </FormGroup>
          </Col>
        </FormGroup>
      </Form>
    )
  }
}

const { Container, Row, Col, Button } = Reactstrap;
class Stock extends React.Component {
  constructor(props) {
    super(props)

    this.getStock = this.getStock.bind(this)
    this.state = {
      stock: props.stock
    }
  }

  getStock(e) {
    let self = this
    $.getJSON('/cases.json?problems=1', (response) => { this.setState({stock: response}) } )
  }

  render() {
    var stock = this.state.stock.map((box) => {
      return (
        <Col xs="3" key={box.id}>
          <Box box={box}/>
        </Col>
      )
    })
    return (
      <Container>
        <Row>
          <Col>
            <h1>Bienvenue sur l'interface approvisionneur de HuitNeufDis!</h1>

            <Button id="refresh" color="primary" onClick={this.getStock}>Rafraichir</Button>
          </Col>
        </Row>
        <Row>
          {stock}
        </Row>
      </Container>
    )
  }
}

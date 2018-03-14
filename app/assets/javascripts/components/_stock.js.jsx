const { Container, Row, Col } = Reactstrap;
class Stock extends React.Component {
  constructor(props) {
    super(props)

    window.getStock = () => {this.getStock}
    this.state = {
      stock: props.stock
    }
  }

  getStock() {
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

            <p><a href="#">Activez les notifications</a> pour recevoir les alertes de stock</p>
          </Col>
        </Row>
        <Row>
          {stock}
        </Row>
      </Container>
    )
  }
}

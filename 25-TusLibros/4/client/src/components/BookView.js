class BookComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      bookData: {},
      amount: 0,
      loading: false,
      error: null,
    }
  }

  componentDidMount() {
    const {
      cartId,
      currentBook,
    } = this.props

    this.setState({
      loading: true,
      error: null,
    })



    let catalog = {}

    getLocalAsJson(`getCatalog`)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        catalog = json
        
        return getLocalAsJson(`listCart?cartId=${cartId}`)
      })
      .then(function (response) {
        return response.json()
      })
      .then(amounts => {
        const amount = amounts[currentBook] || 0
        const bookData = catalog.find(book => book.isbn === currentBook)

        this.setState({
          loading: false,
          bookData,
          amount
        })
      })
      .catch(err => {
        this.setState({
          loading: false,
          error: err,
        })
      })
  }

  handleAdd() {
    const {
      currentBook,
      cartId
    } = this.props

    const {
      amount,
    } = this.state

    getLocalAsJson(`addToCart?cartId=${cartId}&bookIsbn=${currentBook}&bookQuantity=1`)
      .then( response => response.json())
      .then(json => {
        const newAmount = 1 + amount
        this.setState({
          amount: newAmount
        })
      })
      .catch(err => {
        console.log('Looks like there was a problem: \n', err);
        this.setState({
          
          error: err,
        })
      });
  }

  handleRemove() {
    const {
      currentBook,
      cartId
    } = this.props

    const {
      amount,
      bookData
    } = this.state

    getLocalAsJson(`removeFromCart?cartId=${cartId}&bookIsbn=${currentBook}&bookQuantity=1`)
      .then(response => response.json())
      .then(json => {
        const newAmount = amount - 1
        this.setState({
          amount: newAmount
        })
      })
      .catch(error => {
        console.log('Looks like there was a problem: \n', error);
        this.setState({
          error
        })
      });
  }

  render() {
    const {
      cartId,
      classes,
    } = this.props

    const {
      bookData,
      amount,
      loading,
      error,
    } = this.state

    if (loading) return (<div>Loading...</div>)
    if (error) return (<div>{error}</div>)

    return (
      <div>
        <Typography component="h1" gutterBottom>
          Detalles del libro:
          </Typography>
          <Typography component="h2" gutterBottom>
          Título: {bookData.title}
          </Typography>
          <Typography component="h3" gutterBottom>
          ISBN: {bookData.isbn}
          </Typography>
          <Typography component="h3" gutterBottom>
          Autor: {bookData.author}
          </Typography>
          <Typography component="h3" gutterBottom>
          Precio: ${bookData.price}
          </Typography>
          <Typography component="h4" gutterBottom>
          Amount: {amount}
          </Typography>
        <Button
          color="inherit"
          onClick={ev =>this.handleRemove()}
          disabled={amount === 0}>
          Remove
        </Button>
        <Button
          color="inherit"
          onClick={ev =>this.handleAdd()}
          >
          Add
      </Button>
      </div>
    )
  }
}

// Add style
const BookView = withStyles(styles, {
  withTheme: true
})(BookComponent)

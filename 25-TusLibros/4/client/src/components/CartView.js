class CartComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      catalog: [],
      amounts: [],
      ccn: "",
      cced: "",
      cco: "",
      loading: false,
      error: null,
    }
  }

  componentDidMount() {
    const cartId = this.props.cartId

    this.setState({
      loading: true,
      error: null,
    })

    const details = {}

    getLocalAsJson(`getCatalog`)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        details["catalog"] = json
        
        return getLocalAsJson(`listCart?cartId=${cartId}`)
      })
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        details["amounts"] = json
        
        return details
      })
      .then((details) => {
        this.setState({
          loading: false,
          catalog: details["catalog"],
          amounts: details["amounts"]
        })
      })
      .catch(err => {
        this.setState({
          loading: false,
          error: err,
        })
      })
  }

  handleAdd(isbn) {
    const {
      router,
      cartId
    } = this.props

    const {
      amounts,
      error
    } = this.state

    getLocalAsJson(`addToCart?cartId=${cartId}&bookIsbn=${isbn}&bookQuantity=1`)
      .then( response => response.json())
      .then(json => {
        amounts[isbn] = 1 + (amounts[isbn] || 0)
        this.setState({
          amounts: amounts
        })
      })
      .catch(function (error) {
        console.log('Looks like there was a problem: \n', error);
        router.navigate("/error", {})
      });
  }

  handleRemove(isbn) {
    const {
      router,
      cartId
    } = this.props

    const {
      amounts,
      error
    } = this.state

    getLocalAsJson(`removeFromCart?cartId=${cartId}&bookIsbn=${isbn}&bookQuantity=1`)
      .then(response => response.json())
      .then(json => {
        amounts[isbn] = amounts[isbn] - 1
        if(amounts[isbn] === 0){
          delete amounts[isbn]
        }
        this.setState({
          amounts: amounts
        })
      })
      .catch(function (error) {
        console.log('Looks like there was a problem: \n', error);
        router.navigate("/error", {})
      });
  }

  handleDetails(isbn){
    const router = this.props.router
    router.navigate('/bookDetails', {currentBook: isbn  })
  }

  handleChange(event,keyToChange) {
    const o = {}
    o[keyToChange] = event.target.value
    this.setState(o)
  }

  handleSend(event){
    const {
      router,
      cartId
    } = this.props

    const {
      ccn,
      cced,
      cco
    } = this.state

    getLocalAsJson(`checkOutCart?cartId=${cartId}&ccn=${ccn}&cced=${cced}&cco=${cco}`)
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        router.navigate("/ticket", { ticket: json })
      })
      .catch(err => {
        this.setState({
          error: err,
        })
      })
  }

  render() {
    const {
      classes,
    } = this.props

    const {
      ccn,
      cced,
      cco,
      catalog,
      amounts,
      loading,
      error,
    } = this.state


    if (loading) return <div>Loading...</div>
    if (error) return <div>{error}</div>

    return (
      <div>
        <Typography variant="h4" component="h4" gutterBottom>
          <b>Contenido del carrito</b>:
        </Typography>

        <List component="nav" className={classes.rootList}>
          {
            Object.keys(amounts).map((isbn, ix) => {
              const book = catalog.find(b => b.isbn === isbn)
              return (
                <ListItem
                  button
                  key={ix}
                  onClick={() => this.handleDetails(book.isbn)}>
                  <ListItemText primary={book.title + "     " + (amounts[book.isbn] || 0) + "     $" + book.price} secondary={book.isbn} />
                  <ListItemSecondaryAction>
                    <IconButton 
                    onClick={() => this.handleAdd(book.isbn)}>
                      <Icon>add</Icon>
                    </IconButton>
                    <IconButton 
                    onClick={() => this.handleRemove(book.isbn)}>
                      <Icon>remove</Icon>
                    </IconButton>
                  </ListItemSecondaryAction>
                </ListItem>
              )
            })
          }
        </List>
        <Typography variant="h5" component="h5" gutterBottom>
          Datos de tarjeta para Check Out:
        </Typography>
        <TextField className={classes.textField} value={ccn} label="Número de tarjeta de credito" onChange={(ev)=>this.handleChange(ev,"ccn")}/>
        <TextField className={classes.textField} value={cced} label="Fecha de expiración" onChange={(ev)=>this.handleChange(ev,"cced")}/>
        <TextField className={classes.textField} value={cco} label="Nombre" onChange={(ev)=>this.handleChange(ev,"cco")}/>
        <Button
          color="inherit"
          onClick={(ev)=>this.handleSend(ev)}>
          Check Out
      </Button>
      </div>
    )
  }
}

// Add style
const CartView = withStyles(styles, {
  withTheme: true
})(CartComponent)

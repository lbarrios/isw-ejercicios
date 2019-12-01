class CatalogComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      catalog: [],
      amounts: [],
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

  render() {
    const {
      router,
      classes,
    } = this.props

    const {
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
          <b>Catálogo</b>:
        </Typography>

        <List component="nav" className={classes.rootList}>
          {
            catalog.map((book, ix) => {
              return (
                <ListItem
                  button
                  key={ix}
                  onClick={() => router.navigate('/details', {  })}>
                  <ListItemText primary={book.title + "     " + (amounts[book.isbn] || 0) + "     $" + book.price} secondary={book.isbn} />
                  <ListItemSecondaryAction>
                    <IconButton 
                    onClick={() => this.handleAdd(book.isbn)}>
                      <Icon>add</Icon>
                    </IconButton>
                    <IconButton 
                    onClick={() => this.handleRemove(book.isbn)}
                    disabled={amounts[book.isbn] === undefined}>
                      <Icon>remove</Icon>
                    </IconButton>
                  </ListItemSecondaryAction>
                </ListItem>
              )
            })
          }
        </List>
      </div>
    )
  }
}

// Add style
const CatalogView = withStyles(styles, {
  withTheme: true
})(CatalogComponent)

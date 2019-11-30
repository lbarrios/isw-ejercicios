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
                  <ListItemText primary={book.title + "     " + (amounts[book.isbn] || 0)} secondary={book.isbn} />
                  <ListItemSecondaryAction>
                    <IconButton 
                    onClick={() => router.navigate('/', {  })}>
                      <Icon>add</Icon>
                    </IconButton>
                    <IconButton 
                    onClick={() => router.navigate('/', {  })}>
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

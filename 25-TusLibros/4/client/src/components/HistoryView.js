class HistoryComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      catalog: [],
      history: {},
      loading: true,
      error: null,
    }
  }

  componentDidMount() {
    const {
      clientId,
      password
    } = this.props

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
        
        return getLocalAsJson(`listPurchases?clientId=${clientId}&password=${password}`)
      })
      .then(function (response) {
        return response.json()
      })
      .then(function (json) {
        details["list"] = json
        
        return details
      })
      .then((details) => {
        this.setState({
          loading: false,
          catalog: details["catalog"],
          history: details["list"]
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
      classes,
    } = this.props

    const {
      catalog,
      history,
      loading,
      error,
    } = this.state


    if (loading) return <div>Loading...</div>
    if (error) return <div>{error}</div>

    return (
      <div>
        <Typography variant="h4" component="h4" gutterBottom>
          <b>Historial de compras</b>:
        </Typography>
        <List component="nav" className={classes.rootList}>
          {
            Object.keys(history.amounts).map((isbn, ix) => {
              const book = catalog.find(b => b.isbn === isbn)
              return (
                <ListItem
                  key={ix}>
                  <ListItemText primary={book.title + "     " + (history.amounts[isbn])} secondary={book.isbn} />
                </ListItem>
              )
            })
          }
        </List>
        <Typography variant="h5" component="h5" gutterBottom>
          <b>Total gastado</b>: ${history.total}
        </Typography>
      </div>
    )
  }
}

// Add style
const HistoryView = withStyles(styles, {
  withTheme: true
})(HistoryComponent)

class HistoryComponent extends React.Component {
  constructor(props) {
    super(props)

    this.state = {
      history: [],
      loading: false,
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

    getLocalAsJson(`listPurchases?clientId=${clientId}&password=${password}`)
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

        <div>{history}</div>
      </div>
    )
  }
}

// Add style
const HistoryView = withStyles(styles, {
  withTheme: true
})(HistoryComponent)

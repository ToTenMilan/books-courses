import React, { Component } from 'react'

// Use ErrorBoundary whereever app may fail due to external reasons. i.e. connecting to API. Dont wrap whole application.
class ErrorBoundary extends Component {
  state = {
    hasError: false,
    errorMessage: ''
  }

  componentDidCatch = (error, info) => {
    this.setState({ hasError: true, errorMessage: error})
  }

  render() {
    if (this.state.hasError) {
      return <h1>504 server dead</h1>
    } else {
      return this.props.children
    }
  }
}

export default ErrorBoundary

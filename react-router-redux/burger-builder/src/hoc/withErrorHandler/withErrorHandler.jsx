import React, { Component } from 'react';

import Modal from '../../components/UI/Modal/Modal'
import Aux from '../Aux/Aux'

const withErrorHandler = ( WrappedComponent, axios ) => {
    return class extends Component {
        state = {
            error: null
        }

        componentWillMount () { // willMount used (instead of didMount) to be able to handle errors while getting data
            this.reqInterceptor = axios.interceptors.request.use(req => {
                this.setState({ error: null });
                return req
            })
            this.resInterceptor = axios.interceptors.response.use(res => res, error => {
                this.setState({ error: error });
            })
        }

        // THIS IS VERY IMPORTANT
        componentWillUnmount () {
            axios.interceptors.request.eject(this.reqInterceptor)
            axios.interceptors.response.eject(this.resInterceptor)
        } // Prevent memory leaks by removing interseptors

        errorConfirmedHandler = () => {
            this.setState({ error: null });
        }
        
        render() {
            return (
                <Aux>
                    <Modal
                        show={this.state.error}
                        modalClosed={this.errorConfirmedHandler}>
                        {this.state.error ? this.state.error.message : null }
                    </Modal>
                    <WrappedComponent {...this.props} />
                </Aux>
            )
        }
    }
}
 
export default withErrorHandler;
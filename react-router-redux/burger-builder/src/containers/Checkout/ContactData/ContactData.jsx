import React, { Component } from 'react';
import Button from '../../../components/UI/Button/Button'
import Spinner from '../../../components/UI/Spinner/Spinner'
import classes from './ContactData.css'
import axios from '../../../axios-orders'
import Input from '../../../components/UI/Input/Input'

class ContactData extends Component {
    state = {
        name: '',
        email: '',
        address: {
            street: '',
            postalCode: ''
        },
        loading: false
    }

    orderHandler = (event) => {
        event.preventDefault() // submit form will reload the page, which is by default. We prevent this default here
        console.log(this.props.ingredients);
        // alert('You continued')
        this.setState({ loading: true });
        const order = {
            ingredients: this.props.ingredients,
            price: this.props.price, // in real world, calculate such fields (total price) on the backend, because users may manipulate them on frontend
            customer: {
                name: 'gregson peks',
                address: {
                    street: 'yolo streeet',
                    zipcode: '23423',
                    country: 'Neverland'
                },
                email: 'test@test.com'
            },
            deliveryMethod: 'fastest'
        }
        // axios.post('/orders.json', order)
        //     .then(response => console.log(response))
        //     .catch(error => console.log(error))
        axios.post( '/orders.json', order )
            .then(response => {
                this.setState({ loading: false });
                this.props.history.push('/') // redirect to root
            })
            .catch(error => {
                this.setState({ loading: false });
            })
    }

    render() {
        let form = (
            <form>
                <Input inputtype="input" type="text" name="name" placeholder="your name" />
                <Input inputtype="input" type="email" name="email" placeholder="your mail" />
                <Input inputtype="input" type="text" name="street" placeholder="Street" />
                <Input inputtype="input" type="text" name="postal" placeholder="Postal code" />
                <Button btnType="Success" clicked={this.orderHandler}>Order now</Button>
            </form>
        )
        if (this.state.loading) {
            form = <Spinner />
        }
        return (
            <div className={classes.ContactData}>
                <h4>Enter your contact data</h4>
                {form}
            </div>
        );
    }
}
 
export default ContactData;
import React, { Component } from 'react';
import axios from 'axios'

class FullCourse extends Component {
    state = { loadedCourse: null }

    componentDidMount() {
        console.log(this.props.match)
        // if (this.props.match)
        this.loadData()
    }

    componentDidUpdate() {
        console.log(this.props.match)
        // if (this.props.match)
        this.loadData()
    }

    loadData() {
        console.log('load data 1' + this.props.match.params)
        console.log('load data 2' + this.state.loadedCourse)
        if (this.props.match.params.id) {
            console.log('3');
            if (!this.state.loadedCourse || (this.state.loadedCourse && this.state.loadedCourse.id !== this.props.match.params.id)) {
                console.log('4');
                console.log(axios.get('/courses/' + this.props.match.params.id).then(response => { console.log('response: ' + response)} ));
                
                // axios.get('/courses/' + this.props.match.params.id)
                //     .then(response => {
                //         console.log(response.data);
                        
                //         this.setState({ loadedCourse: response.data });
                //     })
                this.setState({ loadedCourse: {
                    id: this.props.match.params.id,
                    title: 'yolo'
                } });
            }
        }
    }

    render() {
        let course = <p style={{textAlign: 'center'}}>Please select a course</p>
        if (this.props.match.params.id) {
            course = <p style={{testAlign: 'center'}}>Loading...</p>
        }
        if (this.state.loadedCourse) {
            course = (
                <div>
                    <h2>Post <span>{this.props.match.params.id}</span>: <span>{this.state.loadedCourse.title}</span></h2>
                    <h3>Description</h3>
                    <p>Lorem ipsum</p>
                    <p>Dolnor sit amet</p>
                </div>
            )
        }

        return course
    }
}
 
export default FullCourse;
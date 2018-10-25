import React, { Component } from 'react';
import axios from 'axios'
import { Redirect } from 'react-router-dom'

import './NewPost.css';

class NewPost extends Component {
    state = {
        title: '',
        body: '',
        author: 'Max',
        submitted: false
    }

    componentDidMount () {
        console.log(this.props);
        
    }

    postDataHandler = () => {
        const post = {
            title: this.state.title,
            body: this.state.body
        }
        axios.post('/posts', post)
            .then(response => {
                console.log(response)
                this.props.history.replace('/posts')
                // this.setState({ submitted: true });
            })
    }

    render () {
        let redirect = null
        if (this.state.submitted) {
            redirect = <Redirect to="/posts" />
        }

        return (
            <div className="NewPost">
                {redirect}
                <h1>Add a Post</h1>
                <label>Title</label>
                <input type="text" value={this.state.title} onChange={(event) => this.setState({title: event.target.value})} />
                <label>Content</label>
                <textarea rows="4" value={this.state.body} onChange={(event) => this.setState({body: event.target.value})} />
                <label>Author</label>
                <select value={this.state.author} onChange={(event) => this.setState({author: event.target.value})}>
                    <option value="Max">Max</option>
                    <option value="Manu">Manu</option>
                </select>
                <button onClick={this.postDataHandler}>Add Post</button>
            </div>
        );
    }
}

export default NewPost;
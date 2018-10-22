import React, { Component } from 'react';
// import axios from '../../axios'

// import Post from '../../components/Post/Post';
import { Route } from 'react-router-dom'
import Posts from '../Blog/Posts/Posts'
import NewPost from '../Blog/NewPost/NewPost'
import './Blog.css';
// import axios from 'axios'

class Blog extends Component {
    

    render () {
        return (
            <div className="Blog">
                <header>
                    <nav>
                        <ul>
                            <li><a href="/">Home</a></li>
                            <li><a href="/new-post">New Post</a></li>
                        </ul>
                    </nav>
                </header>
                {/* <Route path="/" exact render={() => <h1>Home</h1>} /> */}
                <Route path="/" exact component={Posts} />
                <Route path="/new-post" component={NewPost} />
            </div>
        );
    }
}

export default Blog;
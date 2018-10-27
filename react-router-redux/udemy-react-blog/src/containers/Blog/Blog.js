import React, { Component } from 'react';
// import axios from '../../axios'

// import Post from '../../components/Post/Post';
import { Route, NavLink, Switch, Redirect } from 'react-router-dom'
import Posts from './Posts/Posts'
// import NewPost from './NewPost/NewPost'
import asyncComponent from '../../hoc/asyncComponent'
// import FullPost from '../FullPost/FullPost'
import './Blog.css';
// import axios from 'axios'

const AsyncNewPost = asyncComponent(() => {
    return import('./NewPost/NewPost')
})

class Blog extends Component {
    state = {
        auth: true
    }

    render () {
        return (
            <div className="Blog">
                <header>
                    <nav>
                        <ul>
                            <li><NavLink
                                    to="/posts/"
                                    exact
                                    activeClassName="active"
                                    activeStyle={{
                                        color: '#fa923f',
                                        textDecoration: 'underline'
                                    }}
                                >
                                        Posts
                                </NavLink></li>
                            <li><NavLink to={{
                                pathname: "/new-post",
                                hash: '#submit',
                                search: '?quick-submit=true'
                            }}>New Post</NavLink></li>
                        </ul>
                    </nav>
                </header>
                {/* <Route path="/" exact render={() => <h1>Home</h1>} /> */}
                {/* Switch lets match routes one at a time */}
                <Switch>
                    {this.state.auth ? <Route path="/new-post" component={AsyncNewPost} /> : null }
                    <Route path="/posts" component={Posts} />
                    {/* <Route render={() => <h1>404 Not Found</h1> } /> */}
                    <Redirect from="/" to="/posts" />
                </Switch>
                
            </div>
        );
    }
}

export default Blog;
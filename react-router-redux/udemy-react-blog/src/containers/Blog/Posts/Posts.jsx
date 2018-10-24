import React, { Component } from 'react';
import axios from '../../../axios'
import { Route } from 'react-router-dom'
import Post from '../../../components/Post/Post'
import FullPost from '../FullPost/FullPost'
import './Posts.css'
// import { Link } from 'react-router-dom'

class Posts extends Component {
    state = {
        posts: []
    }

    componentDidMount() {
        console.log(this.props);
        
        axios.get('/posts') // axios.get return s a promise, so .then needs to be chained (can't store this in variable cause its async and JS executes sync)
            .then(response => {
                const posts = response.data.slice(0, 4)
                const updatedPosts = posts.map(post => {
                    return {
                        ...post,
                        author: 'Gregson'
                    }
                })
                this.setState({ posts: updatedPosts });
                // console.log(response)
            })
            .catch(error => {
                console.log(error);
                
                // this.setState({ error: true });
            })
    }

    postSelectedHandler = (id) => {
        // this.setState({ selectedPostId: id });

        // different way to access single post without using Link component, is to push route as last element to history
        this.props.history.push({pathname: '/posts/' + id})
        // this.props.history.push('/' + id) // alternative
    }

    render() {
        let posts =<p style={{textAlign: 'center'}}>Something went wrong</p>
        if (!this.state.error) {
            posts = this.state.posts.map(post => {
                return (
                    // <Link to={'/' + post.id} key={post.id}>
                        <Post
                            key={post.id}    
                            title={post.title}
                            author={post.author}
                            
                            clicked={() => this.postSelectedHandler(post.id) } />
                    // </Link>
                )
            })
        }

        return (
            <div>
                <section className="Posts">
                    {posts}
                </section>
                {/* When route is nested like here, component is not rerendering, its updating so compDidUpdate needs to change its contents */}
                <Route path={this.props.match.url + '/:id'} exact component={FullPost} /> 
            </div>
        );
    }
}
 
export default Posts;
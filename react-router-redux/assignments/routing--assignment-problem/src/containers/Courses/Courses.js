import React, { Component } from 'react';
import { Route, Link } from 'react-router-dom'
import Course from '../Course/Course'
import FullCourse from '../FullCourse/FullCourse'

import './Courses.css';

class Courses extends Component {
    state = {
        courses: [
            { id: 1, title: 'Angular - The Complete Guide' },
            { id: 2, title: 'Vue - The Complete Guide' },
            { id: 3, title: 'PWA - The Complete Guide' }
        ]
    }

    courseSelectedHandler = (id) => {
        this.props.history.push({pathname: '/courses/' + id})
    }

    render () {
        return (
            <div>
                <h1>Amazing Udemy Courses</h1>
                <section className="Courses">
                    {
                        this.state.courses.map( course => {
                            // return <article className="Course" key={course.id}>{course.title}</article>;
                            return (
                                <Link to={'/courses/' + course.id} key={course.id} >
                                    <Course
                                        className="Course"
                                        key={course.id}
                                        title={course.title}
                                        id={course.id}
                                        clicked={() => this.courseSelectedHandler(course.id)} />
                                </Link>
                            )
                        } )
                    }
                </section>
                {console.log('url in router' + this.props.match.url)}
                <Route path={ this.props.match.url + '/:id'} exact component={FullCourse} />
            </div>
        );
    }
}

export default Courses;
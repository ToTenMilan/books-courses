import React from 'react';
import User from '../../components/user';

const authIndexPage = (props) => (
    <div>
        <h1>The Auth Page - {props.appName}</h1>
        <User name="Dzambalaja" age={23}></User>
    </div>
);

authIndexPage.getInitialProps = (context) => {
    const promise = new Promise((resolve, reject) => {
        setTimeout(() => {
            resolve({appName: 'supa app auth page'})
        }, 5000)
    })
    
    return promise
}
 
export default authIndexPage;
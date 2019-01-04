import React from 'react';
import User from '../../components/user';

const authIndexPage = () => (
    <div>
        <h1>The Auth Page</h1>
        <User name="Dzambalaja" age={23}></User>
    </div>
);
 
export default authIndexPage;
import React from 'react';
import Link from 'next/link';
import Router from 'next/router';

const errorPage = () => {
    return (
        <div>
            <h1>Sorry man, wrong page</h1>
            <p>Go to <Link href="/"><a>Main</a></Link></p>
            <p>Go to <Link href="/auth"><a>Auth</a></Link></p>
        </div>
    );
}
 
export default errorPage;
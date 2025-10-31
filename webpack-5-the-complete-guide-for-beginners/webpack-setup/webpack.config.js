const path = require('path');

module.exports = {
    // basic setup
    entry: './src/index.js',
    output: {
        filename: 'bundle.js',
        path: path.resolve(__dirname, './dist'),
        publicPath: 'dist/' // need to specify explicitly if served from CDN
    },
    mode: 'none',
    // add images conf
    module: {
        rules: [
            {
                test:  /\.(ttf)$/, // just as an example of another rule
                type: 'asset/resource'
            },
            {
                test: /\.(png|jpg)$/, // if file is png or jpg
                // type: 'asset/resource', //  generates a new file for each resource in output dir, and generates URL to that file.
                // type: 'asset/inline', // inline a file into bundle as a data URI. it generates base64 representation of a file. Doesn't generate new file in output dir. For small asset files, like svg. Browser will make one request, for one bundle file, rather than many requests, like in asset/resource
                type: 'asset', // automatically choose between asset/resource and asset/inline, based on size of the file
                parser: {
                    dataUrlCondition: { // condition to decide between asset/inline and asset/resource. Default size is 8kb
                        maxSize: 3 * 1024 // 3kb (default was 8kb). Smaller inline, larger resource
                    }
                },
            },
            {
                test: /\.txt/,
                type: 'asset/source' // read the content of the file into JS string and inject it directly into JS bundle ,without modifications. No new file in output dir.
            }
        ]
    }
};

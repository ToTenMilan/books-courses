const path = require('path');

module.exports = {
    // basic setup
    entry: './src/index.js',
    output: {
        filename: 'bundle.js',
        path: path.resolve(__dirname, './dist')
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
                type: 'asset/resource' // one of four module types
            }
        ]
    }
};

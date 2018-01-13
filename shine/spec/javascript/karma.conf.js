module.exports = function(config) {
  config.set({
    frameworks: ['jasmine'],
    files: ['**/*.spec.js'],
    preprocessors: { '**/*.spec.js': [ 'webpack' ]},
    // webpack: require('../../config/webpack/test.js'),
    webpack: require('../../config/webpack/test.js'),
    browsers: [ 'PhantomJS' ],
    plugins: [
      'karma-chrome-launcher',
      'karma-tap',
      'karma-sourcemap-loader',
      'karma-webpack' // *** This 'registers' the Karma webpack plugin.
    ],
  })
}


// npm install karma-tap --save-dev
// npm install karma-sourcemap-loader --save-dev

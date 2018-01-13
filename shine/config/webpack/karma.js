const { module: m, resolve, resolveLoader } = require('./test');

module.exports = {
  module: m,
  resolve,
  resolveLoader,
  devtool: 'inline-source-map'
};

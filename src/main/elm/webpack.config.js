var HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {

  entry: './index.js',

  output : {
    path: './../webapp/dist/js',
    filename: 'bundle.[hash].js'
  },

  module: {
    loaders: [{
      test: /\.elm$/,
      exclude: [/elm-stuff/, /node_modules/],
      loader: 'elm-webpack'
    }]
  },

  plugins: [new HtmlWebpackPlugin({
    title: 'Painel VAH',
    template: './index.ejs',
    filename: './../../index.html'
  })]


}
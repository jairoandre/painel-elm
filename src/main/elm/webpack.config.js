var path = require('path');
var HtmlWebpackPlugin = require('html-webpack-plugin');
var ExtractTextPlugin = require("extract-text-webpack-plugin");

console.log("WEBPACK GOOOOO!");

var TARGET_ENV = process.env.npm_lifecycle_event === 'build' ? 'production' : 'development';


if (TARGET_ENV === 'development') {
  console.log('Serving locally...');

  module.exports = {

    entry: [
        //'webpack-dev-server/client?http://' + require("os").hostname() + ':9090/',
        'webpack-dev-server/client?http://10.1.8.118:9090/',
        path.join(__dirname, 'index.js')
    ],

    output: {
      path: path.resolve(__dirname, 'dist/'),
      filename: 'bundle.[hash].js'
    },

    resolve: {
      modulesDirectories: ['node_modules'],
      extensions: ['', '.js', '.elm']
    },

    devServer: {
      inline: true,
      progress: true
    },

    module: {
      loaders: [
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader: 'elm-webpack'
        },
        {
          test: /\.less?$/,
          loader: ExtractTextPlugin.extract("style-loader", "css-loader!postcss-loader!less-loader")
        }
      ]
    },

    plugins: [
      new HtmlWebpackPlugin({
        title: 'Painel VAH',
        template: './index.ejs',
        filename: './index.html'
      }),
      new ExtractTextPlugin("bundle.[hash].css")
    ]

  };

}



if (TARGET_ENV === 'production') {

  console.log('Building for production...');

  module.exports = {

    entry: './index.js',

    output : {
      path: './../webapp/dist/js',
      filename: 'bundle.[hash].js'
    },

    module: {
      loaders: [
        {
          test: /\.elm$/,
          exclude: [/elm-stuff/, /node_modules/],
          loader: 'elm-webpack'
        },
        {
          test: /\.less?$/,
          loader: ExtractTextPlugin.extract("style-loader", "css-loader!postcss-loader!less-loader")
        }
      ]
    },

    plugins:
        [
          new HtmlWebpackPlugin({
            title: 'Painel VAH',
            template: './index.ejs',
            filename: './../../index.html'}),
          new ExtractTextPlugin("bundle.[hash].css")
        ]

  };

}


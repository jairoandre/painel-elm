'use strict'

require('./src/assets/scss/Default.less');
var Elm = require('./src/Main.elm');

Elm.Main.embed(document.getElementById('main'));
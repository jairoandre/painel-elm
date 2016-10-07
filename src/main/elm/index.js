'use strict'

require('./src/assets/scss/Painel.less');
var Elm = require('./src/Main.elm');

Elm.Main.embed(document.getElementById('main'));
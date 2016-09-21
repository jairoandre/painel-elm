# painel-elm

A dashboard for monitoring pacients and rooms in a hospital using Elm in the frontent and Java in the back.

## Technical description

This project uses JX-RS to provide a RESTfull service for the frontend.
The Elm code lies in the folder `src/main/webapp/painel`.

## Build instructions

To make the bundle for the frontend application:

`elm make Main.elm --output=../dist/js/bundle.js`

$ = require 'jquery'
React = require 'react'

Root = React.createClass
  render: ->
    <div>
      { 1 + 1 }
    </div>

$ ->
  React.render(
    <Root />
  , document.getElementById('container')
  )

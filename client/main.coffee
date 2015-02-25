root = exports ? this

Meteor.startup ->
  new FastClick(document.body)

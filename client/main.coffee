root = exports ? this

Meteor.startup ->
  new FastClick(document.body)

root.dateFormat = (date) ->
  moment(date).format('YYYY-MM-DD')

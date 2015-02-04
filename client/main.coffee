root = exports ? this

Meteor.startup ->
  new FastClick(document.body)

  #TODO fake notifications until i can confirm toast function working again.
  window.toast = window.toast || ((message)-> console.log(message))

root.dateFormat = (date) ->
  moment(date).format('YYYY-MM-DD')

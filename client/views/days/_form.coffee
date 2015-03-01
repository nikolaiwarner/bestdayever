save_post = ->
  description = $('.day_form .description').val()
  if day=Days.findOne({day: @day_string})
    Days.update {_id: day._id}, {$set: {description: description}}, ->
      $('.save-status.saved').fadeIn()
  else
    Days.insert {description: description}, ->
      $('.save-status.saved').fadeIn()

Template.day_form.events
  'click .save': ->
    save_post()
    toast('Saved.', 5000)

  'keydown .description': ->
    $('.save-status.saved').hide()

  'keyup .description': _.throttle(save_post, 1000)

Template.day_form.rendered = ->
  $('.tooltipped').tooltip({delay: 50})

Template.day_form.helpers
  entry: (description) ->
    if $('.day_form .description').is(':focus')
      $('.day_form .description').val()
    else
      description

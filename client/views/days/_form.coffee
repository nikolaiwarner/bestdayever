Template.day_form.events
  'keydown .description': ->
    $('.save-status.saved').hide()

  'keyup .description': _.throttle( (evt) ->
    description = $('.day_form .description').val()
    if day=Days.findOne({day: @day_string})
      Days.update {_id: day._id}, {$set: {description: description}}, ->
        console.log("Saved.")
        $('.save-status.saved').fadeIn()
    else
      Days.insert {description: description}, ->
        console.log("Saved.")
        $('.save-status.saved').fadeIn()
  , 1000)

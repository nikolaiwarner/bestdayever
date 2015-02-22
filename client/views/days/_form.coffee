Template.day_form.events
  'keyup .description': _.throttle( (evt) ->
    description = $('.day_form .description').val()
    if day=Days.findOne({day: @day_string})
      Days.update {_id: day._id}, {$set: {description: description}}, ->
        console.log("Saved.")
    else
      Days.insert {description: description}, ->
        console.log("Saved.")
  , 1000)

Template.day_index.helpers
  created_an_entry_today: ->
    day_string = dateFormat()
    Days.findOne({day: day_string})

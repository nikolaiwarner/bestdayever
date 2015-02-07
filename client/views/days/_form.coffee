AutoForm.hooks
  dayForm:
    after:
      insert: (error, result, template) ->
        if error
          toast(error.message, 5000)
        else
          day = Days.findOne(result)
          day_string = dateFormat(day.day)
          Router.go("/days/#{day_string}")
          toast("Saved.", 5000)
      update: (error, result, template) ->
        if error
          toast(error.message, 5000)
        else
          day_string = template.data.doc.day
          day = Days.findOne({day: day_string})
          day_string = dateFormat(day.day)
          Router.go("/days/#{day_string}")
          toast("Saved.", 5000)
      remove: (error, result, template) ->
        if error
          toast(error.message, 5000)
        else
          Router.go("/")
          toast("Removed.", 5000)

Template.day_form.helpers
  method: ->
    if @day then 'update' else 'insert'

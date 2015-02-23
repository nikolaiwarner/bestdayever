clean_days_data_for_json_export = (days) ->
  data = []
  for day in days.fetch()
    data.push
      date: day.day
      post: day.description
      created_at: day.createdAt
      updated_at: day.updatedAt
  return data

Template.page_account.events
  'change input.import.csv': ->
    $('.btn.import.csv').show()
  'click .export.csv': (e) ->
    data = clean_days_data_for_json_export(@days)
    csv = Papa.unparse(data)
    e.target.href = "data:text/csv;charset=utf-8," + escape(csv)
    e.target.download = "best-of-today-export-#{dateFormat()}.csv"

  'click .export.json': (e) ->
    data = clean_days_data_for_json_export(@days)
    json = JSON.stringify(data)
    blob = new Blob([json], {type: "application/json"})
    e.target.href = URL.createObjectURL(blob)
    e.target.download = "best-of-today-export-#{dateFormat()}.json"

  'click .btn.import.csv': (e) ->
    results = Papa.parse $('input.import.csv')[0].files[0],
      complete: (results) ->
        console.log(results)
        if results.errors.length < 1
          Meteor.call 'import_from_csv_array', results.data, (error, result) ->
            if error
              console.log error
            else
              toast("Imported posts!", 5000)
        else
          toast("There was an error importing the CSV file.", 5000)

Template.page_account.helpers
  avatar_google: ->
    @user.services.google.picture
  username: ->
    @user.profile.name

Meteor.methods
  import_from_csv_array: (data) ->
    for row in data
      day =
        userId: Meteor.userId()
        day: moment(row[0]).format('YYYY-MM-DD')
        description: row[1]
        createdAt: moment(row[0]).toDate()
      existing_post = Days.findOne({day: day.day})
      if existing_post
        console.log "Post exists already for this date."
      else
        if day.day != "Invalid date"
          Days.insert day, {getAutoValues: false}

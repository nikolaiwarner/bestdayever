Meteor.methods
  import_from_csv_array: (data) ->
    for row in data
      day =
        userId: Meteor.userId()
        day: dateFormat(row[0])
        description: row[1]
        createdAt: moment(dateFormat(row[0])).toDate()
      existing_post = Days.findOne({day: day.day, userId: Meteor.userId()})
      if existing_post
        console.log "Post exists already for this date."
      else
        if day.day != "Invalid date"
          Days.insert day, {getAutoValues: false}

  remove_all_posts_from_account: =>
    Days.remove({userId: Meteor.userId()})

  destroy_account: =>
    Days.remove({userId: Meteor.userId()})
    Meteor.users.remove(Meteor.userId())

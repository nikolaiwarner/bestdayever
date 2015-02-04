Meteor.publish 'days_by_user', (userId) ->
  return Days.find({userId: userId})

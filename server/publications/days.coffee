Meteor.publish 'days_by_user', (userId, limit) ->
  return Days.find({userId: userId})

Meteor.publish 'all_days_by_user', (userId) ->
  return Days.find({userId: userId})

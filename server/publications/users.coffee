Meteor.publish "userData", ->
  if @userId
    Meteor.users.find {_id: @userId},
      fields:
        'profile': 1
        'services.google.picture': 1
  else
    @ready()

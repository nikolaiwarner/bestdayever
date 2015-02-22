UI.registerHelper "userIsCurrentUser", (_id) ->
  return null unless _id
  Meteor.userId() == _id

UI.registerHelper "avatar", (_id) ->
  return null unless _id
  if user=Users.findOne(_id: _id)
    if user.services && user.services.google
      url = user.services.google.picture
    else
      return null

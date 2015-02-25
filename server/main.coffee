Meteor.startup ->
  # Days.remove({})

Accounts.onCreateUser (options, user) ->
  if options.profile
    user.profile = options.profile
  # Set default user values
  user.profile.timezone = 'America/New_York'
  return user

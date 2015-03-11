Meteor.startup ->
  # Days.remove({})
  # send_daily_reminder_email()

Accounts.onCreateUser (options, user) ->
  if options.profile
    user.profile = options.profile
  # Set default user values
  user.profile.timezone = 'America/New_York'
  user.profile.mail_key = Meteor.uuid()
  return user

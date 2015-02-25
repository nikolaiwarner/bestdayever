root = exports ? this

root.dateFormat = (date, format='YYYY-MM-DD') ->
  timezone = 'America/New_York'
  if Meteor.user()
    timezone = Meteor.user().profile.timezone
  moment(date).tz(timezone).format(format)

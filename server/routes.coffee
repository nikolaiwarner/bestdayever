Router.route '/email-to-post',
  where: 'server'
  action: ->
    sender = @request['body']['sender']
    recipient = @request['body']['recipient']
    body = @request['body']['stripped-text']
    # get the user's special mail key
    key = recipient.split('+')[1].split('@')[0]
    # find user and post the body to today's entry
    if user=Meteor.users.findOne({ "profile.mail_key": key, "services.google.email": sender })
      date_string = moment().tz(user.profile.timezone).format('YYYY-MM-DD')
      if day=Days.findOne({day: date_string})
        entry = day.description + " " + body
        Days.update {_id: day._id}, {$set: {description: entry}}
      else
        day =
          userId: user._id
          day: date_string
          description: body
          createdAt: moment(date_string).toDate()
        Days.insert day, {getAutoValues: false}

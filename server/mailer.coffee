root = exports ? this

root.send_daily_reminder_email = ->
  users = Meteor.users.find().fetch()
  for user in users
    # does user want a reminder?
    if user.profile.reminder_time
      # is it time to send this user an email?
      if user.profile.reminder_time == moment().tz(user.profile.timezone).format('H')
        from_email = "Best Day Ever <bestdayever+#{user.profile.mail_key}@#{Meteor.settings.mailgun.domain}>"
        date = moment().tz(user.profile.timezone).format('LL')
        if to_email=user.services.google.email
          email =
            from: from_email
            to: to_email
            subject: "Writing reminder - #{date}"
            text: '''
              It's time to write about your day. Your best day ever!

              Reply to this email to post to today's journal entry!

              http://bestdayever.nwarner.com
              '''
          mailer = new Mailgun(Meteor.settings.mailgun)
          mailer.send email

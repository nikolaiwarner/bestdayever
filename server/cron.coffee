SyncedCron.add
  name: 'Send daily email reminders'
  schedule: (parser) ->
    parser.recur().on(0).minute()
  job: ->
    users = Meteor.users.find().fetch()
    for user in users
      # does user want a reminder?
      if user.profile.reminder_time
        # is it time to send this user an email?
        if user.profile.reminder_time == moment().tz(user.profile.timezone).format('H')
          from_email = Meteor.settings.mailgun.from_email
          date = moment().tz(user.profile.timezone).format('LL')
          if to_email=user.services.google.email
            email =
              from: from_email
              to: to_email
              subject: "Writing reminder - #{date}"
              text: '''
                It's time to write about your day. Your best day ever!

                http://bestdayever.nwarner.com
                '''
            mailer = new Mailgun(Meteor.settings.mailgun)
            mailer.send email


SyncedCron.start()

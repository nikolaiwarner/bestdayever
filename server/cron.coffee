SyncedCron.add
  name: 'Send daily email reminders'
  schedule: (parser) ->
    parser.recur().on(0).minute()
  job: ->
    send_daily_reminder_email()

SyncedCron.start()

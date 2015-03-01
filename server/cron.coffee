SyncedCron.add
  name: 'Send email reminders'
  schedule: (parser) ->
    parser.recur().on(0).minute()
  job: ->
    console.log "SENDING REMINDER EMAILS"
    #TODO send emails

SyncedCron.start()

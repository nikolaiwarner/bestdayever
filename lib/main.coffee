root = exports ? this

root.dateFormat = (date, format='YYYY-MM-DD') ->
  TIMEZONE = 'America/New_York'
  moment(date).tz(TIMEZONE).format(format)

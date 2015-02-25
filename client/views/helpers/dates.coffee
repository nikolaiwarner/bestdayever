UI.registerHelper "dateFormat", (date, options={}) ->
  return null unless date
  dateFormat(date, options.format)

UI.registerHelper "longDateFormat", (date, options={}) ->
  dateFormat(date, 'LL')

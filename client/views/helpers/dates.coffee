UI.registerHelper "dateFormat", (context, options={}) ->
  return null unless context
  options.format = options.format || "YYYY-MM-DD"
  moment(date).format(options.format)

UI.registerHelper "longDateFormat", (context, options={}) ->
  return null unless context
  moment(context).format('LL')

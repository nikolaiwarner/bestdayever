Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'

Router.onBeforeAction ->
  $("body,html").scrollTop 0
  GAnalytics.pageview this.url
  this.next()

Router.onBeforeAction (->
  if !Meteor.loggingIn() && !Meteor.user()
    Router.go('/')
  else
    this.next()
), {except: ['page_landing']}

Router.route '/signout',
  name: 'signout'
  action: ->
    Meteor.logout()
    Router.go('/')

Router.route '/',
  name: 'page_landing'
  template: 'page_landing'
  onBeforeAction: ->
    if Meteor.user()
      Router.go('/today')
    else
      this.next()

Router.route '/everyday',
  name: 'day_index'
  template: 'day_index'
  waitOn: ->
    Meteor.subscribe 'days_by_user', Meteor.userId()
  data: ->
    days: Days.find({userId: Meteor.userId()}, {sort: {createdAt: -1}})

Router.route '/today',
  name: 'day_new'
  template: 'day_new'
  onBeforeAction: ->
    day_string = dateFormat()
    if Days.findOne({day: day_string})
      # Router.go('/days/' + day_string)
      this.render('day_show')
    else
      this.next()
  waitOn: ->
    Meteor.subscribe 'days_by_user', Meteor.userId()
  data: ->
    day_string = moment().format('YYYY-MM-DD')
    if day=Days.findOne({day: day_string})
      day: day

Router.route '/days/:_day_string',
  name: 'day_show'
  template: 'day_show'
  waitOn: ->
    Meteor.subscribe 'days_by_user', Meteor.userId()
  data: ->
    day_string = @params._day_string
    if day=Days.findOne({day: day_string})
      day: day
    else
      Router.go('/')

Router.route '/days/:_day_string/edit',
  name: 'day_edit'
  template: 'day_edit'
  waitOn: ->
    Meteor.subscribe 'days_by_user', Meteor.userId()
  data: ->
    day_string = @params._day_string
    if day=Days.findOne({day: day_string})
      day: day
    else
      Router.go('/')

Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'page_notfound'

Router.plugin 'dataNotFound', {notFoundTemplate: 'page_notfound'}

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

# Subscribe on all routes
Router.before ->
  this.subscribe('userData')
  this.next()

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

Router.route '/all-the-days',
  name: 'day_index'
  template: 'day_index'
  waitOn: ->
    Meteor.subscribe 'days_by_user', Meteor.userId()
  data: ->
    days: Days.find({userId: Meteor.userId()}, {sort: {createdAt: -1}})
    day_string: dateFormat()

Router.route '/today',
  name: 'day_new'
  template: 'day_new'
  waitOn: ->
    Meteor.subscribe 'days_by_user', Meteor.userId()
  data: ->
    day_string = dateFormat()
    day: Days.findOne({day: day_string})
    day_string: day_string

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
      day_string: day_string
    else
      Router.go('/')

Router.route '/account',
  name: 'page_account'
  template: 'page_account'
  waitOn: ->
    Meteor.subscribe 'all_days_by_user', Meteor.userId()
  data: ->
    user: Meteor.user()
    days: Days.find({userId: Meteor.userId()}, {sort: {createdAt: -1}})

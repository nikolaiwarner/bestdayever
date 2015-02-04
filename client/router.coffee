Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'

Router.route '/',
  name: 'page_landing'
  template: 'page_landing'
  onBeforeAction: ->
    if Meteor.user()
      Router.go('/days')
    else
      this.next()

Router.route '/days',
  name: 'day_index'
  template: 'day_index'
  onBeforeAction: ->
    if !Meteor.user()
      Router.go('/')
    else
      this.next()
  waitOn: ->
    Meteor.subscribe 'days_by_user', Meteor.userId()
  data: ->
    days: Days.find({userId: Meteor.userId()}, {sort: {createdAt: -1}})

Router.route '/today',
  name: 'day_new'
  template: 'day_new'
  onBeforeAction: ->
    if !Meteor.user()
      Router.go('/')
    else
      day_string = dateFormat()
      if Days.findOne({day: day_string})
        Router.go('/days/' + day_string)
      else
        this.next()
  waitOn: ->
    Meteor.subscribe 'days_by_user', Meteor.userId()

Router.route '/days/:_day_string',
  name: 'day_show'
  template: 'day_show'
  onBeforeAction: ->
    if !Meteor.user()
      Router.go('/')
    else
      this.next()
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
  onBeforeAction: ->
    if !Meteor.user()
      Router.go('/')
    else
      this.next()
  waitOn: ->
    Meteor.subscribe 'days_by_user', Meteor.userId()
  data: ->
    day_string = @params._day_string
    if day=Days.findOne({day: day_string})
      day: day
    else
      Router.go('/')

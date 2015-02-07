setup_navbar_dropdown = ->
  setTimeout ->
    $('.dropdown-button').dropdown({hover: false})
  , 1000

Template.layout.rendered = ->
  $('.button-collapse').sideNav({menuWidth: 240, activationWidth: 70})
  setup_navbar_dropdown()

Template.layout.helpers
  signed_in: ->
    !!Meteor.user()
  username: ->
    Meteor.user().profile.name

Template.layout.events
  'click .signin': (e) ->
    e.preventDefault()
    Meteor.loginWithGoogle ->
      setup_navbar_dropdown()

  'click .signout': (e) ->
    e.preventDefault()
    Meteor.logout()

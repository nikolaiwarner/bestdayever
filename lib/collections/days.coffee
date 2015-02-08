root = exports ? this

root.Days = new Meteor.Collection('days')

days_schema = new SimpleSchema
  userId:
    type: String
    denyUpdate: true
    autoValue: ->
      if @isInsert
        Meteor.userId()

  createdAt:
    type: Date
    denyUpdate: true
    autoValue: ->
      if @isInsert
        new Date()

  updatedAt:
    type: Date
    denyInsert: true
    optional: true
    autoValue: ->
      if @isUpdate
        new Date()

  day:
    type: String
    index: 1
    denyUpdate: true
    autoValue: ->
      if @isInsert
        moment().format('YYYY-MM-DD')

  description:
    type: String
    max: 1500
    optional: true

root.Days.attachSchema(days_schema, {transform: true})

root.Days.allow
  insert: (userId, doc) ->
    userId && (doc.userId == userId)

  update: (userId, doc, fieldNames, modifier) ->
    userId && (doc.userId == userId)

  remove: (userId, doc, fieldNames, modifier) ->
    userId && (doc.userId == userId)

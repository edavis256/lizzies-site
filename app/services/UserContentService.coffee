app.factory 'UserContentService', ->
  userContent = []
  return {
    get: ->
      userContent
  }

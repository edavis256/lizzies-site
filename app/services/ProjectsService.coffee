app.factory 'ProjectsService', ->
  projects = []
  names = ['Art', 'cat', 'writing', 'stuff', 'things']
  # TODO: make this pull from a file that lizzie can write
  # and generate array from that file.
  for i in [0..4]
    name = "
    #{names[Math.floor((Math.random()*names.length)%names.length)]}
    #{names[Math.floor((Math.random()*names.length)%names.length)]}"
    project =
      id: i
      name: name
      description: "#{name} is just another cool project of mine!"
    projects.push project

  return {
    list: ->
      return projects
    find: (id)->
      if projects[id]? then return projects[id]
      return {
        id: id,
        name: 'anonymous',
        description: 'project info goes here'
      }
  }

app.factory 'ProjectsService', ['$http', ($http)->
  @projects = []
  # TODO: add function to undasherize, uncamelcase, and un-underscore filenames
  getFiles = (results)->
    projects = []
    files = results.split('\n')
    i = 0
    files.filter (file)->
      file = file.trim()
      if file.endsWith('.md')
        data = {
          id: i
          name: file.substr 0, (file.length - 3)
          path: "assets/text/projects/#{file}"
        }
        projects.push data
        i++
        return data
    @projects = projects
    return projects

  getProjects = (cb)->
    $http(
      method: 'GET'
      url: 'assets/text/projects/index.md'
    ).then (res)->
      projects = getFiles(res.data)
      cb(projects)

  return {
    list: ->
      getProjects (projects)->
        return projects
  }
]

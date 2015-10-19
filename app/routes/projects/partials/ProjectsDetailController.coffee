app.controller 'ProjectsDetailController', ['$scope', 'ProjectsService', 'project'
($scope, ProjectsService, project)->
  $scope.selectedProject = project
]

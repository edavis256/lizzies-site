app.controller 'ProjectsController', ['$scope', 'ProjectsService',
($scope, ProjectsService)->
  $scope.projects = ProjectsService.list()
]

app.controller 'ProjectsDetailController', ['$scope', '$stateParams', 'ProjectsService',
($scope, $stateParams, ProjectsService)->
  $scope.selectedProject = ProjectsService.find($stateParams.id)
]

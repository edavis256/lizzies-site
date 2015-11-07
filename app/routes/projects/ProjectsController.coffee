app.controller 'ProjectsController', ['$scope', 'ProjectsService',
($scope, ProjectsService, $mdDialog)->
  $scope.projects = []
  ProjectsService.list().then (res)->
    $scope.projects = res
]

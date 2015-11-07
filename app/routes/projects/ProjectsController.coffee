app.controller 'ProjectsController', ['$scope', 'ProjectsService',
($scope, ProjectsService, $mdDialog)->
  $scope.projects = []
  ProjectsService.list().then (res)->
    $scope.projects = res
    $scope.selectedProject = res[0]

  $scope.redirectOrShowProjectInfo = (ev, project)->
    $scope.selectedProject = project

  $scope.isExternalLink = (projectPath)->
    
]

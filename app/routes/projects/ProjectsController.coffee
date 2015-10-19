app.controller 'ProjectsController', ['$scope', 'ProjectsService', '$mdDialog',
($scope, ProjectsService, $mdDialog)->
  $scope.projects = []
  ProjectsService.list().then (res)->
    $scope.projects = res
    $scope.selectedProject = res[0]

  $scope.showDialog = (ev, project)->
    $scope.selectedProject = project
    $mdDialog.show
      controller: 'ProjectsDetailController'
      templateUrl: 'routes/projects/partials/project-detail.html'
      parent: angular.element(document.body)
      targetEvent: ev
      locals: { project: project }
      clickOutsideToClose: true
]

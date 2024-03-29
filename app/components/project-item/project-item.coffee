app.directive 'projectItem', ['$window', ($window)->
  return {
    scope: {}
    templateUrl: 'components/project-item/project-item.html'
    link: ($scope, el, attrs)->
      $scope.data = JSON.parse(attrs.data)
      $scope.modalVisible = false

      $scope.toggleModal = (e)->
        $scope.modalVisible = !$scope.modalVisible
        body = document.getElementsByTagName('body')[0]
        angular.element(body).toggleClass('no-scroll')
        return true

      $scope.handleClicked = (e)->
        if $scope.data.type == 'link'
          $window.open($scope.data.path)
        else
          $scope.toggleModal()
        return true

  }
]

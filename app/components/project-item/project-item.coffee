app.directive 'projectItem', ->
  return {
    scope: {}
    templateUrl: 'components/project-item/project-item.html'
    link: ($scope, el, attrs)->
      $scope.data = JSON.parse attrs.data
      $scope.modalVisible = false

      $scope.toggleModal = (e)->
        $scope.modalVisible = !$scope.modalVisible

      $scope.handleClicked = (e)->
        if $scope.data.type == 'link'
          window.location = $scope.data.path
          console.log 'click!', $scope
        else
          $scope.toggleModal()

  }

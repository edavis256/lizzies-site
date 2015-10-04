app.directive 'userContent', ->
  return {
    scope: {}
    restrict: 'E'
    templateUrl: 'components/user-content/user-content.html'
    transclude: true
    link: ($scope, element, attrs)->
      $scope.test = true
  }

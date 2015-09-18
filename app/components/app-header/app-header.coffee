app.directive 'appHeader', ->
  return {
    scope: {}
    restrict: 'E'
    templateUrl: 'components/app-header/app-header.html'
    link: ($scope, element, attrs)->
      $scope.test = true
  }

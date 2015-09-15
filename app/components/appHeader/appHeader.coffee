app.directive 'appHeader', ->
  return {
    scope: {}
    restrict: 'E'
    templateUrl: 'appHeader/appHeader.html'
    link: ($scope, element, attrs)->
      console.log "here's the appHeader crew", $scope, element, attrs
  }

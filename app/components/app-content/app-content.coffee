app.directive 'appContent', ->
  return {
    scope: {}
    restrict: 'E'
    transclude: true
    templateUrl: 'components/app-content/app-content.html'
    controller: ['$scope', '$element', ($scope, $element)->
      $scope.contentElement = $element
    ]
    link: (scope, el, attrs, ctrl, transclude)->
      el.find('.transContent').append transclude()
  }

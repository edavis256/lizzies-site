app.directive 'appFooter', ['$timeout', ($timeout)->
  return {
    require: '^appContent'
    restrict: 'E'
    templateUrl: 'components/app-footer/app-footer.html'
    transclude: true
    scope: {
      contentElement: '@'
    }
    link: ($scope, $element, $attrs, contentCtrl)->
      # # console.log 'hallo?', contentCtrl, $scope
      # # TODO: figure out how to make an
      # # angular sticky footer...
      #
      # wrapper = contentCtrl
      # wrapper.parent().css 'height', '100%'
      # wrapper.css
      #   'min-height': '100%'
      #   'height': 'auto'
      # stickyPusher = angular.element '<div class="push"></div>'
      # setHeights = ->
      #   height = $element.outerHeight()
      #   stickyPusher.height(height)
      #   wrapper.css 'margin-bottom', -(height)
      #
      # $timeout(setHeights, 0)
      # window.on 'resize', setHeights
  }
]

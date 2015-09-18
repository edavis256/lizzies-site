app.controller 'UsersDetailController', ['$scope', '$stateParams', 'UsersService',
($scope, $stateParams, UsersService)->
  $scope.selectedUser = UsersService.find($stateParams.id)
]

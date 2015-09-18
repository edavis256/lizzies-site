app.controller 'UsersController', ['$scope', 'UsersService',
($scope, UsersService)->
  $scope.users = UsersService.list()
]

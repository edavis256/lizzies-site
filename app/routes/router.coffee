app.config ['$stateProvider', '$urlRouterProvider',
($stateProvider, $urlRouterProvider)->
  $urlRouterProvider.otherwise '/'
  $stateProvider

    .state 'about',
      url: '/about'
      templateUrl: 'routes/about/about.html'

    .state 'home',
      url: '/'
      templateUrl: 'routes/home/home.html'

    .state 'users',
      url: '/users'
      templateUrl: 'routes/users/users.html'
      controller: 'UsersController'

    .state 'users.detail',
      url: '/detail/:id'
      templateUrl: 'routes/users/partials/user-detail.html'
      controller: 'UsersDetailController'
]

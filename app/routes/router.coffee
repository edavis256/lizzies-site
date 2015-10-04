app.config ['$stateProvider', '$urlRouterProvider',
($stateProvider, $urlRouterProvider)->
  $urlRouterProvider.otherwise '/'
  $stateProvider
    .state 'home',
      url: '/'
      templateUrl: 'routes/home/home.html'

    .state 'contact',
      url: '/contact'
      templateUrl: 'routes/contact/contact.html'

    .state 'cv',
      url: '/cv'
      templateUrl: 'routes/cv/cv.html'

    .state 'projects',
      url: '/projects'
      templateUrl: 'routes/projects/projects.html'
      controller: 'ProjectsController'

    .state 'projects.detail',
      url: '/detail/:id'
      templateUrl: 'routes/projects/partials/project-detail.html'
      controller: 'ProjectsDetailController'
]

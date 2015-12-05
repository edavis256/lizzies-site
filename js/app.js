(function() {
  window.app = angular.module('app', ['ui.router', 'btford.markdown']);

}).call(this);

(function() {
  app.factory('ProjectsService', [
    '$http', function($http) {
      var getFiles, getProjects, handleLink, handleMd;
      this.projects = [];
      handleMd = function(i, file) {
        return {
          id: i,
          name: file.substr(0, file.length - 3),
          path: "assets/text/projects/" + file,
          type: 'markdown'
        };
      };
      handleLink = function(i, file) {
        return {
          id: i,
          name: file.substring(1, file.lastIndexOf(']')),
          path: file.substring(file.indexOf('(') + 1, file.length - 1),
          type: 'link'
        };
      };
      getFiles = function(results) {
        var files, i, projects;
        projects = [];
        files = results.split('\n');
        i = 0;
        files.filter(function(file) {
          var data;
          file = file.trim();
          if (file.endsWith('.md')) {
            data = handleMd(i, file);
            projects.push(data);
            i++;
            return data;
          } else if (file.endsWith(')')) {
            data = handleLink(i, file);
            projects.push(data);
            i++;
            return data;
          }
        });
        this.projects = projects;
        return projects;
      };
      getProjects = function(cb) {
        return $http({
          method: 'GET',
          url: 'assets/text/projects/index.md'
        }).then(function(res) {
          var projects;
          projects = getFiles(res.data);
          return cb(projects);
        });
      };
      return {
        list: function() {
          return getProjects(function(projects) {
            return projects;
          });
        }
      };
    }
  ]);

}).call(this);

(function() {
  app.config([
    '$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {
      $urlRouterProvider.otherwise('/');
      return $stateProvider.state('home', {
        url: '/',
        templateUrl: 'routes/home/home.html'
      }).state('contact', {
        url: '/contact',
        templateUrl: 'routes/contact/contact.html'
      }).state('cv', {
        url: '/cv',
        templateUrl: 'routes/cv/cv.html'
      }).state('projects', {
        url: '/projects',
        templateUrl: 'routes/projects/projects.html',
        controller: 'ProjectsController'
      });
    }
  ]);

}).call(this);

(function() {
  app.directive('appContent', function() {
    return {
      scope: {},
      restrict: 'E',
      transclude: true,
      templateUrl: 'components/app-content/app-content.html',
      controller: [
        '$scope', '$element', function($scope, $element) {
          return $scope.contentElement = $element;
        }
      ],
      link: function(scope, el, attrs, ctrl, transclude) {
        return el.find('.transContent').append(transclude());
      }
    };
  });

}).call(this);

(function() {
  app.directive('appHeader', function() {
    return {
      scope: {},
      restrict: 'E',
      templateUrl: 'components/app-header/app-header.html',
      link: function($scope, element, attrs) {
        return $scope.test = true;
      }
    };
  });

}).call(this);

(function() {
  app.directive('appFooter', [
    '$timeout', function($timeout) {
      return {
        require: '^appContent',
        restrict: 'E',
        templateUrl: 'components/app-footer/app-footer.html',
        transclude: true,
        scope: {
          contentElement: '@'
        },
        link: function($scope, $element, $attrs, contentCtrl) {}
      };
    }
  ]);

}).call(this);

(function() {
  app.directive('projectItem', [
    '$window', function($window) {
      return {
        scope: {},
        templateUrl: 'components/project-item/project-item.html',
        link: function($scope, el, attrs) {
          $scope.data = JSON.parse(attrs.data);
          $scope.modalVisible = false;
          $scope.toggleModal = function(e) {
            var body;
            $scope.modalVisible = !$scope.modalVisible;
            body = document.getElementsByTagName('body')[0];
            angular.element(body).toggleClass('no-scroll');
            return true;
          };
          return $scope.handleClicked = function(e) {
            if ($scope.data.type === 'link') {
              $window.open($scope.data.path);
            } else {
              $scope.toggleModal();
            }
            return true;
          };
        }
      };
    }
  ]);

}).call(this);

(function() {
  app.controller('ProjectsController', [
    '$scope', 'ProjectsService', function($scope, ProjectsService, $mdDialog) {
      $scope.projects = [];
      return ProjectsService.list().then(function(res) {
        return $scope.projects = res;
      });
    }
  ]);

}).call(this);

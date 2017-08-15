var app = angular.module("app1",[]);

app.controller('MainCtrl', ['$scope', '$http', function($scope, $http) {
    $scope.items = [];
    $http.get('filelist/customicondesign-office1-reflection.txt').success(function(data){
    angular.forEach(data,function(item, ind){
      $scope.items.push(item);
    });
  });
}]);

app.controller('PathCtrl', ['$scope', '$http', function($scope, $http) {
    $scope.paths = [];
    $http.get('pathlist/website.txt').success(function(data){
      angular.forEach(data,function(item, ind){
        $scope.paths.push(item);
      });
    });
}]);
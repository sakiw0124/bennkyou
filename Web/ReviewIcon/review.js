var app = angular.module("app1",[]);

app.controller('MainCtrl', ['$scope', '$http', function($scope, $http) {
    $scope.paths = [];
    $http.get('pathlist/website.txt').success(function(data){
      angular.forEach(data,function(item, ind){
        $scope.paths.push(item);
      });
      $scope.sel = {style : $scope.paths[0].style};
    });
}]);

app.controller('PathCtrl', ['$scope', '$http', function($scope, $http) {
    $scope.items = [];
    $scope.website = "customicondesign.com";
    $scope.style = "customicondesign-office1-reflection";
    $http.get('filelist/' + $scope.website + '/' + $scope.style + '.txt').success(function(data){
    angular.forEach(data,function(item, ind){
      $scope.items.push(item);
    });
  });
}]);

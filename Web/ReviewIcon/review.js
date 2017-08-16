var app = angular.module("app1",[]);

app.controller('MainCtrl', ['$scope', '$http', function($scope, $http) {
    $scope.paths = [];
    $http.get('pathlist/website.txt').success(function(data){
      angular.forEach(data,function(item, ind){
        $scope.paths.push(item);
      });
      $scope.selwebsite = $scope.paths[0].website; //為什麼這裡的預設值不能成功?
      $scope.selstyle = $scope.paths[0].styles[0];
      $scope.websitechange = function (){ 
        $scope.selstyle = $scope.selwebsite.styles[0];};
    });
}]);

app.controller('PathCtrl', ['$scope', '$http', function($scope, $http) {
    //到底要怎麽取得MainCtrl的scope呀
    $scope.items = [];
    $scope.website = "customicondesign.com";
    $scope.style = "customicondesign-office1-reflection";
    $http.get('filelist/' + $scope.website + '/' + $scope.style + '.txt').success(function(data){
    angular.forEach(data,function(item, ind){
      $scope.items.push(item);
    });
  });
}]);
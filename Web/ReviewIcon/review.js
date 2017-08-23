var app = angular.module("app1",[]);

app.controller('MainCtrl', ['$scope', '$http', function($scope, $http) {
    $scope.paths = [];
    $http.get('pathlist/website.txt').success(function(data){
      angular.forEach(data,function(item, ind){
        $scope.paths.push(item);
      });
      $scope.selwebsite = $scope.paths[0]; //前面select的用法, 兩個model都是object, 所以預設值也要是object
      $scope.selstyle = $scope.paths[0].styles[0];
      $scope.websitechange = function (){ 
        $scope.selstyle = $scope.selwebsite.styles[0];
      };
      $scope.$watch('selstyle', function(){
        $scope.$broadcast('sendselect',{'website':$scope.selwebsite,'style':$scope.selstyle});
        //console.log('send:',$scope.selwebsite,' and ',$scope.selstyle);
      })
    });
    $scope.websites = [];
    $http.get('pathlist/website2.txt').success(function(data){
      angular.forEach(data,function(item, ind){
        $scope.websites.push(item);
      });
      $scope.chgwebsite = $scope.websites[0];
      $scope.$watch('chgwebsite', function(newValue, oldValue) {
        console.log('choose:',$scope.chgwebsite);
        $scope.directory = 'filelist/' + $scope.chgwebsite.website + '/directory.txt'
        $scope.directorys = [];
        $http.get($scope.directory).success(function(data) {
          angular.forEach(data,function(item, ind){
            $scope.directorys.push(item);
          });
          $scope.chgstyle = $scope.directorys[0];
          $scope.$watch('chgstyle', function(newValue, oldValue) {
            $scope.$broadcast('sendselect',{'website':$scope.chgwebsite,'style':$scope.chgstyle});
          });
        });
      });
    });
}]);

app.controller('PathCtrl', ['$scope', '$http', function($scope, $http) {
    $scope.$on('sendselect', function(event, data) {
      //console.log('get:',data.website.website,' and ', data.style.style);
      if (data.website.website == null || data.style.style == null) {
        console.log('取不到值');
      }
      else {
        $scope.selwebsite = data.website.website;
        $scope.selselstyle = data.style.style;
        //console.log('parse:',$scope.selwebsite,' and ',$scope.selselstyle);
        $scope.items = [];
        $scope.file = 'filelist/' + $scope.selwebsite + '/' + $scope.selselstyle + '.txt';
        $http.get($scope.file).success(function(data){
          angular.forEach(data,function(item, ind){
            $scope.items.push(item);
          });
        })
        .error(function (error) {
          console.log('檔案不存在:', $scope.file);
        });
      }
    });
}]);
var app = angular.module("app1",[]);

app.controller('MainCtrl', ['$scope', '$http', function($scope, $http) {
    $scope.countys = [
    {county: '台北',
    districts: [{dName:'中正區'},{dName:'中山區'}]}
    ,{county: '台中',
    districts: [
        {dName:'東區'}
      ,{dName: '北區'}]}];
// countyField 和 districtField用到的 model 應該可以不用宣告，會自動產生
// 這邊宣告則是為了給予初始值，這部份工作也可使用 ng-init 完成
$scope.county = $scope.countys[0];
$scope.district = $scope.countys[0].districts[0];  
//縣市變更後，AngularJS 會自動更新 ng-model(county), 鄉鎮也會自動更新成（ c in county.districts)
//資料方面不用擔心。但是由於不會自動設定預設選項，所以這邊要設定預設項目
$scope.countyChange = function (){ 
    console.log('county:',$scope.county);
    console.log('district:',$scope.district);
$scope.district = $scope.county.districts[0];}
}]);
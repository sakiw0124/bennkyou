var app = angular.module("app1",[]);

app.controller('MainCtrl', ['$scope', '$http', function($scope, $http) {
    // $scope.paths = [];
    // $http.get('pathlist/website.txt').success(function(data){
    //   angular.forEach(data,function(item, ind){
    //     $scope.paths.push(item);
    //   });
    //   $scope.selwebsite = $scope.paths[0]; //前面select的用法, 兩個model都是object, 所以預設值也要是object
    //   $scope.selstyle = $scope.paths[0].styles[0];
    //   $scope.websitechange = function (){ 
    //     $scope.selstyle = $scope.selwebsite.styles[0];
    //   };
    //   $scope.$watch('selstyle', function(){
    //     $scope.$broadcast('sendselect',{'website':$scope.selwebsite,'style':$scope.selstyle});
    //     //console.log('send:',$scope.selwebsite,' and ',$scope.selstyle);
    //   })
    // });
    $scope.websites = [];
    $scope.sorticon = "fa fa-sort";
    $scope.choosestyle = "s"+new Date().getDay();
    $http.get('pathlist/website2.json').success(function(data){
      angular.forEach(data,function(item, ind){
        $scope.websites.push(item);
      });
      $scope.chgwebsite = $scope.websites[0];
      $scope.$watch('chgwebsite', function(newValue, oldValue) {
        //console.log('choose:',$scope.chgwebsite);
        $scope.directory = 'filelist/' + $scope.chgwebsite.website + '/000_directory.json'
        $scope.directorys = [];
        $http.get($scope.directory).success(function(data) {
          angular.forEach(data,function(item, ind){
            $scope.directorys.push(item);
          });
          $scope.chgseries = $scope.directorys[0];
        });
      });
      $scope.$watch('chgseries', function(newValue, oldValue) {
        if (newValue != undefined && newValue != null) {
          $scope.$broadcast('sendselect',{'website':$scope.chgwebsite,'series':$scope.chgseries}); //往子階層推送變數, 在子階層用on接
          $scope.$on('SendTotalCount', function(event,data) {
            //console.log('total:',data.totalcount);
            $scope.totalcount=data.totalcount; //我這是不是一種不合規則的做法? 用這樣送給view?
          });
        }
      });
      var flag;
      $scope.changesorting = function () {
        if (flag == null) {
          flag = 'B';
        }
        //switch這東西是每個case都會跑過檢查, 所以正確就要break出去
        switch (flag) {
          case 'A':
            $scope.sortfield = "";
            $scope.direction = "";
            $scope.sorticon = "fa fa-sort";
            flag = 'B';
            break;
          case 'B':
            $scope.sortfield = "header";
            $scope.direction = 0;
            $scope.sorticon = "fa fa-sort-alpha-asc";
            flag = 'C';
            break;
          case 'C':
            $scope.sortfield = "header";
            $scope.direction = 1;
            $scope.sorticon = "fa fa-sort-alpha-desc";
            flag = 'A';
            break;
          default:
            $scope.sortfield = "";
            $scope.direction = "";
            $scope.sorticon = "fa fa-sort";
            flag = 'B';
            break;
        };
      };
      $scope.clearkeyword = function () {
        $scope.keyword = "";
      };
    });
}]);

app.controller('PathCtrl', ['$scope', '$http', function($scope, $http) {
    $scope.$on('sendselect', function(event, data) {
      //console.log('get:',data.website.website,' and ', data.style.style);
      if (data.website.website == null || data.series.series == null || data.series.series == undefined) {
        console.log('取不到值');
      }
      else {
        $scope.selwebsite = data.website.website;
        $scope.selseries = data.series.series;
        //console.log('parse:',$scope.selwebsite,' and ',$scope.selselstyle);
        $scope.imgclassid='col_img_size48';
        if ($scope.selseries.match('white') != null || $scope.selseries.match('general1-light') != null || 
            $scope.selseries.match('general2-light') != null || $scope.selseries.match('general3-light') != null ||
            $scope.selseries.match('general4-light') != null) {
          $scope.divclassid='card-white';
        }
        else {
          $scope.divclassid='';
        }
        $scope.items = [];
        $scope.file = 'filelist/' + $scope.selwebsite + '/' + $scope.selseries + '.json';
        $http.get($scope.file).success(function(data){
          angular.forEach(data,function(item, ind){
            $scope.items.push(item);
          });
          $scope.$emit('SendTotalCount',{'totalcount':$scope.items.length}); //往父接層推送變數, 在父階層用on接
        })
        .error(function (error) {
          console.log('檔案不存在:', $scope.file);
        });
      }
    });
    $scope.openimg = function (item,classid) {
      $scope.openimg_header = item.header;
      $scope.openimg_path = item.path;
      $scope.openimg_classid = classid;
    };
}]);

app.filter('strReplace', function () {
  return function (input, from, to) {
    input = input || '';
    from = from || '';
    to = to || '';
    return input.replace(new RegExp(from, 'g'), to);
  };
});
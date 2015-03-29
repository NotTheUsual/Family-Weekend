'use strict';

var postEditor = angular.module('postEditor', []);

postEditor.controller('PostCtrl', ['$scope', 
  function($scope) {
    $scope.output = '';

    Dropzone.options.postDropzone = {
      maxFiles: 1,
      success: function(file, response) {
        $scope.output = JSON.parse(response).post.body;
        $scope.$digest();
      }
    };
  }
]);

postEditor.filter('markdown', ['$sce', function($sce) {
  return function(value) {
    var converter = new Showdown.converter();
    var html = converter.makeHtml(value || '');
    return $sce.trustAsHtml(html)
  };
}]);


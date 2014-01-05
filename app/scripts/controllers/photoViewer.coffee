angular.module('flicksieAngularApp')
.controller 'PhotoViewerCtrl', ($scope, photoSelector, flickr)->
  $scope.getActivePhotoUrl = () ->
    photo = photoSelector.getActivePhoto()
    flickr.getPhotoUrl( photo ) if photo?

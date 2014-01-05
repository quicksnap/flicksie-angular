'use strict'

angular.module('flicksieAngularApp')
.controller 'PhotoListCtrl', ($scope, flickr, photoSelector) ->
  $scope.model = flickr.getPhotos()

  $scope.selectPhoto = (photo) ->
    photoSelector.setActivePhoto(photo)

  $scope.getSelectedId = () ->
    photo = photoSelector.getActivePhoto()
    if photo then photo.id else null

  $scope.isLoading = flickr.isLoading

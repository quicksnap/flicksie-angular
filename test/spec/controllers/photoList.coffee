'use strict'

describe 'Controller: PhotoListCtrl', () ->

  # load the controller's module
  beforeEach module 'flicksieAngularApp'

  PhotoListCtrl = {}
  scope = {}
  flickr = { getPhotos: ()-> }

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope, $injector) ->
    scope = $rootScope.$new()
    spyOn(flickr, 'getPhotos').andReturn({photos: [1,2,3]})

    PhotoListCtrl = $controller 'PhotoListCtrl', {
      $scope: scope
      flickr: flickr
    }

  it 'should assign Flickr photos to scope', () ->
    expect(scope.model.photos.length).toBe 3

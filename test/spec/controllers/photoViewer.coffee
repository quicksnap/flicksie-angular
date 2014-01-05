'use strict'

describe 'Controller: PhotoViewer', () ->
  PhotoViewer = null
  scope = null

  beforeEach () ->
    module 'flicksieAngularApp'
    inject ($injector, $controller, $rootScope) ->
      scope = $rootScope.$new()
      PhotoViewer = $controller 'PhotoViewerCtrl', {
        $scope: scope
      }

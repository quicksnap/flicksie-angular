'use strict'

describe 'Service: PhotoSelector', () ->

  photoSelector = null
  photo = {id: 'baz'}

  beforeEach () ->
    module 'flicksieAngularApp'
    inject ($injector)->
      photoSelector = $injector.get 'photoSelector'

  it 'sets active photo', () ->
    photoSelector.setActivePhoto photo
    expect(photoSelector.getActivePhoto()).toBe photo
    photoSelector.setActivePhoto {id: 'foo'}
    expect(photoSelector.getActivePhoto()).not.toBe photo

'use strict'

angular.module('flicksieAngularApp')
.service 'photoSelector', () ->
  _photo = null

  @getActivePhoto = () ->
    return _photo

  @setActivePhoto = (photo) ->
    _photo = photo

  return true
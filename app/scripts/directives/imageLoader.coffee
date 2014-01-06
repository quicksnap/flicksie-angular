app = angular.module('flicksieAngularApp')

app.directive 'imageLoader', ($log) ->
  postLink = (scope, iElement, iAttrs) ->

    iElement.wrap '<div class="load-wrapper"></div>'
    wrapper = iElement.parent()
    wrapper.addClass('img-loading')
    $log.log wrapper
    $log.log iElement
    initImgLoaded = (ele) ->
      ele.imagesLoaded().always (instance) ->
        wrapper.removeClass('img-loading')
    initImgLoaded(iElement)

    scope.$watch( () ->
      return iAttrs.src
    , ()->
      wrapper.addClass('img-loading')
      initImgLoaded(iElement)
    )

  return {
    scope: {}
    link: postLink
  }
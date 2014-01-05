app = angular.module('flicksieAngularApp')

app.service 'flickr', ($http) ->
  PHOTOS_URL = 'http://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=1cbbcda881bad35d5dd13634ad5b5035&per_page=10&format=json&jsoncallback=JSON_CALLBACK'

  _isLoading = false

  @isLoading = () ->
    return _isLoading

  @getPhotos = (next) ->
    _isLoading = true
    @model ||= { photos: [] }
    $http.jsonp(PHOTOS_URL).success (data) =>
      @model.photos = data.photos.photo
      _isLoading = false
      next(@model) if typeof next == 'function'
    return @model

  @getPhotoUrl = (photo, options) ->
    options = angular.extend {size: 'b'}, options

    # http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
    return "http://farm#{photo.farm}.staticflickr.com/#{photo.server}/#{photo.id}_#{photo.secret}_#{options.size}.jpg"

  return true
'use strict'

describe 'Service: Flickr', () ->
  $httpBackend = null
  flickr = null
  FLICKR_PHOTOS_RESPONSE = { "photos": { "page": 1, "pages": "200", "perpage": 5, "total": "1000", "photo": [
      { "id": "11715933295", "owner": "80242862@N08", "secret": "fe1b1fd4b8", "server": "5535", "farm": 6, "title": "Pannenkoekenschip", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
      { "id": "11716194673", "owner": "41025162@N00", "secret": "509969fee8", "server": "5483", "farm": 6, "title": "IMG_5729", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
      { "id": "11716301334", "owner": "39333259@N08", "secret": "d90c0b4f73", "server": "2807", "farm": 3, "title": "DSC_4886.jpg", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
      { "id": "11716302744", "owner": "106569336@N07", "secret": "c2e60b8d48", "server": "5548", "farm": 6, "title": "OLYMPUS DIGITAL CAMERA", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
      { "id": "11716302854", "owner": "112871545@N04", "secret": "92905206e1", "server": "5523", "farm": 6, "title": "", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
    ] }, "stat": "ok" }

  beforeEach ->
    module 'flicksieAngularApp'
    inject ($injector)->
      flickr = $injector.get('flickr')
      $httpBackend = $injector.get('$httpBackend')
      $httpBackend.when('JSONP').respond(FLICKR_PHOTOS_RESPONSE)

  it 'returns a list of photos from flickr', () ->
    model = flickr.getPhotos()
    $httpBackend.expectJSONP()
    $httpBackend.flush()
    expect(model.photos.length).toBe 5 # Race?

  it 'maintains accurate loading state', () ->
    model = flickr.getPhotos()
    expect( flickr.isLoading() ).toBe(true)
    $httpBackend.flush()
    expect( flickr.isLoading() ).toBe(false)

  it 'returns a single photo URL, with large size default', () ->
    # http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
    photo = FLICKR_PHOTOS_RESPONSE.photos.photo[0]
    photoUrl = flickr.getPhotoUrl(photo)
    expect(photoUrl).toBe 'http://farm6.staticflickr.com/5535/11715933295_fe1b1fd4b8_b.jpg'
    photo = FLICKR_PHOTOS_RESPONSE.photos.photo[1]
    photoUrl = flickr.getPhotoUrl(photo)
    expect(photoUrl).toBe 'http://farm6.staticflickr.com/5483/11716194673_509969fee8_b.jpg'

  it 'returns a single photo URL with optional size param', () ->
    photo = FLICKR_PHOTOS_RESPONSE.photos.photo[0]
    photoUrl = flickr.getPhotoUrl(photo, {size: 'b'} )
    expect(photoUrl).toBe 'http://farm6.staticflickr.com/5535/11715933295_fe1b1fd4b8_b.jpg'
    photoUrl = flickr.getPhotoUrl(photo, {size: 's'} )
    expect(photoUrl).toBe 'http://farm6.staticflickr.com/5535/11715933295_fe1b1fd4b8_s.jpg'


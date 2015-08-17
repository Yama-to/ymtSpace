###*
# zoom.js - It's the best way to zoom an image
# @version v0.0.2
# @link https://github.com/fat/zoom.js
# @license MIT
###

+(($) ->

  ###*
  # The zoom service
  ###

  ZoomService = ->
    @_activeZoom = @_initialScrollPosition = @_initialTouchPosition = @_touchMoveListener = null
    @_$document = $(document)
    @_$window = $(window)
    @_$body = $(document.body)
    @_boundClick = $.proxy(@_clickHandler, this)
    return

  ###*
  # The zoom object
  ###

  Zoom = (img) ->
    @_fullHeight = @_fullWidth = @_overlay = @_targetImageWrap = null
    @_targetImage = img
    @_$body = $(document.body)
    return

  'use strict'

  ZoomService::listen = ->
    @_$body.on 'click', '[data-action="zoom"]', $.proxy(@_zoom, this)
    return

  ZoomService::_zoom = (e) ->
    target = e.target
    if !target or target.tagName != 'IMG'
      return
    if @_$body.hasClass('zoom-overlay-open')
      return
    if e.metaKey or e.ctrlKey
      return window.open(e.target.getAttribute('data-original') or e.target.src, '_blank')
    if target.width >= $(window).width() - (Zoom.OFFSET)
      return
    @_activeZoomClose true
    @_activeZoom = new Zoom(target)
    @_activeZoom.zoomImage()
    # todo(fat): probably worth throttling this
    @_$window.on 'scroll.zoom', $.proxy(@_scrollHandler, this)
    @_$document.on 'keyup.zoom', $.proxy(@_keyHandler, this)
    @_$document.on 'touchstart.zoom', $.proxy(@_touchStart, this)
    # we use a capturing phase here to prevent unintended js events
    # sadly no useCapture in jquery api (http://bugs.jquery.com/ticket/14953)
    if document.addEventListener
      document.addEventListener 'click', @_boundClick, true
    else
      document.attachEvent 'onclick', @_boundClick, true
    if 'bubbles' of e
      if e.bubbles
        e.stopPropagation()
    else
      # Internet Explorer before version 9
      e.cancelBubble = true
    return

  ZoomService::_activeZoomClose = (forceDispose) ->
    if !@_activeZoom
      return
    if forceDispose
      @_activeZoom.dispose()
    else
      @_activeZoom.close()
    @_$window.off '.zoom'
    @_$document.off '.zoom'
    document.removeEventListener 'click', @_boundClick, true
    @_activeZoom = null
    return

  ZoomService::_scrollHandler = (e) ->
    if @_initialScrollPosition == null
      @_initialScrollPosition = $(window).scrollTop()
    deltaY = @_initialScrollPosition - $(window).scrollTop()
    if Math.abs(deltaY) >= 40
      @_activeZoomClose()
    return

  ZoomService::_keyHandler = (e) ->
    if e.keyCode == 27
      @_activeZoomClose()
    return

  ZoomService::_clickHandler = (e) ->
    if e.preventDefault
      e.preventDefault()
    else
      event.returnValue = false
    if 'bubbles' of e
      if e.bubbles
        e.stopPropagation()
    else
      # Internet Explorer before version 9
      e.cancelBubble = true
    @_activeZoomClose()
    return

  ZoomService::_touchStart = (e) ->
    @_initialTouchPosition = e.touches[0].pageY
    $(e.target).on 'touchmove.zoom', $.proxy(@_touchMove, this)
    return

  ZoomService::_touchMove = (e) ->
    if Math.abs(e.touches[0].pageY - (@_initialTouchPosition)) > 10
      @_activeZoomClose()
      $(e.target).off 'touchmove.zoom'
    return

  Zoom.OFFSET = 80
  Zoom._MAX_WIDTH = 2560
  Zoom._MAX_HEIGHT = 4096

  Zoom::zoomImage = ->
    img = document.createElement('img')
    img.onload = $.proxy((->
      @_fullHeight = Number(img.height)
      @_fullWidth = Number(img.width)
      @_zoomOriginal()
      return
    ), this)
    img.src = @_targetImage.src
    return

  Zoom::_zoomOriginal = ->
    @_targetImageWrap = document.createElement('div')
    @_targetImageWrap.className = 'zoom-img-wrap'
    @_targetImage.parentNode.insertBefore @_targetImageWrap, @_targetImage
    @_targetImageWrap.appendChild @_targetImage
    $(@_targetImage).addClass('zoom-img').attr 'data-action', 'zoom-out'
    @_overlay = document.createElement('div')
    # @_brand = document.getElementById('brand')
    @_overlay.className = 'zoom-overlay'
    @_overlay.id = 'zoom-overlay'
    document.body.appendChild(@_overlay)
    @_calculateZoom()
    @_triggerAnimation()
    return

  Zoom::_calculateZoom = ->
    @_targetImage.offsetWidth
    # repaint before animating
    originalFullImageWidth = @_fullWidth
    originalFullImageHeight = @_fullHeight
    scrollTop = $(window).scrollTop()
    maxScaleFactor = originalFullImageWidth / @_targetImage.width
    viewportHeight = $(window).height() - (Zoom.OFFSET)
    viewportWidth = $(window).width() - (Zoom.OFFSET)
    imageAspectRatio = originalFullImageWidth / originalFullImageHeight
    viewportAspectRatio = viewportWidth / viewportHeight
    if originalFullImageWidth < viewportWidth and originalFullImageHeight < viewportHeight
      @_imgScaleFactor = maxScaleFactor
    else if imageAspectRatio < viewportAspectRatio
      @_imgScaleFactor = viewportHeight / originalFullImageHeight * maxScaleFactor
    else
      @_imgScaleFactor = viewportWidth / originalFullImageWidth * maxScaleFactor
    return

  Zoom::_triggerAnimation = ->
    @_targetImage.offsetWidth
    # repaint before animating
    imageOffset = $(@_targetImage).offset()
    scrollTop = $(window).scrollTop()
    viewportY = scrollTop + $(window).height() / 2
    viewportX = $(window).width() / 2
    imageCenterY = imageOffset.top + @_targetImage.height / 2
    imageCenterX = imageOffset.left + @_targetImage.width / 2
    @_translateY = viewportY - imageCenterY
    @_translateX = viewportX - imageCenterX
    targetTransform = 'scale(' + @_imgScaleFactor + ')'
    imageWrapTransform = 'translate(' + @_translateX + 'px, ' + @_translateY + 'px)'
    if $.support.transition
      imageWrapTransform += ' translateZ(0)'
    $(@_targetImage).css
      '-webkit-transform': targetTransform
      '-ms-transform': targetTransform
      'transform': targetTransform
    $(@_targetImageWrap).css
      '-webkit-transform': imageWrapTransform
      '-ms-transform': imageWrapTransform
      'transform': imageWrapTransform
    @_$body.addClass 'zoom-overlay-open'
    return

  Zoom::close = ->
    @_$body.removeClass('zoom-overlay-open').addClass 'zoom-overlay-transitioning'
    # we use setStyle here so that the correct vender prefix for transform is used
    $(@_targetImage).css
      '-webkit-transform': ''
      '-ms-transform': ''
      'transform': ''
    $(@_targetImageWrap).css
      '-webkit-transform': ''
      '-ms-transform': ''
      'transform': ''
    if !$.support.transition
      return @dispose()
    $(@_targetImage).one($.support.transition.end, $.proxy(@dispose, this)).emulateTransitionEnd 300
    return

  Zoom::dispose = ->
    if @_targetImageWrap and @_targetImageWrap.parentNode
      $(@_targetImage).removeClass('zoom-img').attr 'data-action', 'zoom'
      @_targetImageWrap.parentNode.replaceChild @_targetImage, @_targetImageWrap
      @_overlay.parentNode.removeChild(@_overlay)
      @_$body.removeClass 'zoom-overlay-transitioning'
    return

  # wait for dom ready (incase script included before body)
  $ ->
    (new ZoomService).listen()
    return
  return
)(jQuery)

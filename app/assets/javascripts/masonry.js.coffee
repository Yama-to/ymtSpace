$ ->
  $('#masonry-container').masonry
    itemSelector: '.masonry-box',
    gutterWidth: 8,
    isAnimated: true,
    isFitWidth: true,
    animationOptions: {
      duration: 500,
      easing: 'swing'
    }
    # columnWidth: (containerWidth) -> containerWidth / 10
# $ ->
#   $('.mas-box').hide();
#   $('.mas-box').each((i) ->
#     $(this).delay(i * 100).fadeIn(1000))

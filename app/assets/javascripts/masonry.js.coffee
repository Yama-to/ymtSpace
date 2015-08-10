$ ->
  $container = $('#masonry-container')
  $container.imagesLoaded ->
    $container.masonry
      itemSelector: '.masonry-box',
      gutterWidth: 8,
      isAnimated: true,
      isFitWidth: true,
      animationOptions: {
        duration: 500,
        easing:   'swing'
      }
  $container.infinitescroll
      navSelector : '.pagination',
      nextSelector : 'a#next_page',
      itemSelector : '.masonry-box',
      loading : {
          finishedMsg : 'NO MORE POSTS',
          img : 'http://i.imgur.com/6RMhx.gif',
      }
      , (newElements) ->
        $newElems = $(newElements).css opacity: 0
        $newElems.imagesLoaded ->
          $newElems.animate opacity: 1
          $container.masonry 'appended', $newElems, true

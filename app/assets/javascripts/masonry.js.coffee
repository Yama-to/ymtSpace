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
          img : 'https://s3-ap-northeast-1.amazonaws.com/ymt-space/loading_circle.gif?X-Amz-Date=20150810T174055Z&X-Amz-Expires=300&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Signature=334f0e7f60a7418743114f760513b44f0fa6b99ecc52f3c734e606d9b8739023&X-Amz-Credential=ASIAIPSHISAKMLPM3B4Q/20150810/ap-northeast-1/s3/aws4_request&X-Amz-SignedHeaders=Host&x-amz-security-token=AQoDYXdzEI///////////wEakALf4HRe4Km0x79wVnsj8lTFce23L2STfmAbV65P15ZmKsqU9/AnTzXrFkMcUNBPagOdLL/tZ12uJkzE%2BX9sCbyF1/vsbs45QM8b50qzT6LXtcp9IbFkoeLr2MEuAmgydj0u053EgI/iReemf9r8sHbUmRLsgYENgqeZpeXTRlFJRg0tYNrN/khwzpTv0d3Hf5bbFVKSEfDOeHDQ81wVFuwQGN9mA1GWQPlo2DIVUSpckANb9NIE/fXL8wnWp5JI%2BKRD5TyHrEKhO0mBdJG/07%2BsTTAq3lCQAqJO/QeDRVk415dEsSesWKMVf1/wpTGfp6LRazdaYzzgWeeDmURyKOxzowKf2YVXwh12BixE6cotEyCm16KuBQ%3D%3D',
      }
      , (newElements) ->
        $newElems = $(newElements).css opacity: 0
        $newElems.imagesLoaded ->
          $newElems.animate opacity: 1
          $container.masonry 'appended', $newElems, true

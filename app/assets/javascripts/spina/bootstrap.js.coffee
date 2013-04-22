ready = ->
  $('.royalSlider').royalSlider
    keyboardNavEnabled: true,
    controlNavigation: 'none',
    imageScaleMode: 'fill',
    autoPlay:
      enabled: true,
      pauseOnHover: true,
      delay: 4000


$(document).ready(ready)
$(document).on('page:load', ready)
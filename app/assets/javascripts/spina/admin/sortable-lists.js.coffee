ready = ->
  $('ol.sortable').nestedSortable
    listType: 'ol'
    items: 'li'
    disableNesting: 'no-nest',
    placeholder: 'placeholder'
    forcePlaceholderSize: true
    handle: 'div'
    tolerance: 'pointer'
    toleranceElement: '> div'
    maxLevels: 3
    update: ->
      $.post $(this).data('update-url'), $(this).serializelist()#nestedSortable("serialize", key: "menu[]")

$(document).ready(ready)
$(document).on('page:load', ready)
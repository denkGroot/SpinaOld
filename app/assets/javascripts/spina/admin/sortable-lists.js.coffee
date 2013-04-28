ready = ->
  $('ol.sortable').nestedSortable
    forcePlaceholderSize: true
    placeholder: 'placeholder'
    handle: 'div'
    items: 'li'
    tolerance: 'pointer'
    toleranceElement: '> div'
    maxLevels: 2
    update: ->
      $.post($(this).data('update-url'), $(this).nestedSortable('serialize'))

$(document).ready(ready)
$(document).on('page:load', ready)
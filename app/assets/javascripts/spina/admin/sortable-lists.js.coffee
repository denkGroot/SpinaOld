ready = ->
  $('ol.sortable').nestedSortable
    handle: 'div'
    items: "li"
    toleranceElement: '> div'
    maxLevels: 2
    update: ->
      $.post($(this).data('update-url'), $(this).nestedSortable('serialize'))

$(document).ready(ready)
$(document).on('page:load', ready)
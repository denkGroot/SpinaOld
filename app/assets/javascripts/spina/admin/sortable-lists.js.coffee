ready = ->
  $('ul.sortable').nestedSortable(
    helper: fixHelper,
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
  ).disableSelection()

$(document).ready(ready)
$(document).on('page:load', ready)
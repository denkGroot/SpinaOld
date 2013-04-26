ready = ->
  $('table.sortable tbody').nestedSortable(
    helper: fixHelper,
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
  ).disableSelection()

fixHelper = (e, ui) ->
  $('.ui-sortable-placeholder').height($(this).height())
  ui.children().each ->
    $(this).width($(this).width())
  return ui

$(document).ready(ready)
$(document).on('page:load', ready)
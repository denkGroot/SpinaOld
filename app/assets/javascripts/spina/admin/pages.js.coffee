ready = ->
  if $('.page-template').length > 0
    page_parts = $('.page-template').data('page-parts')
    show_page_parts(page_parts)

$(document).on 'ready page:load', ready

$(document).on 'change', '.page-template select', ->
  page_parts = $(this).find('option:selected').data('page-parts').split(" ")
  show_page_parts(page_parts)

show_page_parts = (page_parts) ->
  $('tr.page-part').hide()
  for page_part in page_parts
    $('tr.page-part[data-name=' + page_part + ']').show()

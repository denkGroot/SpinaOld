ready = ->
  if $('.page-template').length > 0
    page_parts = $('.page-template').data('page-parts')
    show_page_parts(page_parts)

  $('.sortable-grid').sortable().bind 'sortupdate', (e) ->
    position_array = []
    $(e.target).find('li.image').each (index) ->
      position_array.push $(this).data('photo-id')
    $(e.target).parents('td').find('.photo-positions').val(position_array.join(","))

$(document).on 'ready page:load', ready

# Change templates makes page parts appear and disappear
$(document).on 'change', '.page-template select', ->
  page_parts = $(this).find('option:selected').data('page-parts').split(" ")
  show_page_parts(page_parts)

show_page_parts = (page_parts) ->
  $('tr.page-part').hide()
  for page_part in page_parts
    $('tr.page-part[data-name=' + page_part + ']').show()

# Dynamically add and remove fields in a nested form
$(document).on 'click', 'form .add_fields', (event) ->
  time = new Date().getTime()
  regexp = new RegExp($(this).data('id'), 'g')
  $(this).before($(this).data('fields').replace(regexp, time))
  event.preventDefault()

$(document).on 'click', 'form .remove_fields', (event) ->
  $(this).prev('input[type=hidden]').val('1')
  $(this).closest('fieldset').slideUp()
  event.preventDefault()

# Sort pages
$(document).on 'click', '.sort-switch', (event) ->
  $($(this).attr('href') + ' .dd-item-inner').toggleClass('dd-handle')
  if $(this).attr('data-icon') == 'j'
    $(this).attr('data-icon', '8')
    $(this).removeClass('button-success')
    $(this).addClass('button-link')
    $(this).text('Volgorde wijzigen')
  else
    $(this).attr('data-icon', 'j')
    $(this).addClass('button-success')
    $(this).removeClass('button-link')
    $(this).text('Klaar met slepen')
  return false

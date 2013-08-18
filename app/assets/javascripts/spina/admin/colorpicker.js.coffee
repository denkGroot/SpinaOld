jQuery ->
  # Color pickers
  $('input[data-colorpicker]').each ->
    $(this).wrap('<div class="colorpicker" />')
    $(this).parent().append('<div class="colorpicker-container" />')

  $('.colorpicker').each ->
    colorpicker = $(this).find('.colorpicker-container')
    field = $(this).find('input')

    $.farbtastic colorpicker, (color) ->
      field.val(color)
      field.css('color', color)

  $('.colorpicker input').focus ->
    container = $(this).parent()
    colorpicker = container.find('.colorpicker-container')
    $.farbtastic(colorpicker).setColor($(this).val())
    container.find('.farbtastic').show()

  $('.colorpicker input').blur ->
    container = $(this).parent()
    container.find('.farbtastic').hide()
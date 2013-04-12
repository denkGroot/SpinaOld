featherEditor = new Aviary.Feather
  apiKey: 'N7Aoe3eOAEe8P5hJGR5PQw',
  apiVersion: 2,
  language: 'nl',
  minimumStyling: true,
  tools: 'enhance,stickers,contrast,sharpness,text,whiten,effects,warmth,orientation,brightness,saturation,draw,redeye,blemish',
  appendTo: '',
  onSave: (imageID, newURL) ->
    img = $('#' + imageID)
    img.attr('src', newURL)
    $.post(img.attr('data-posturl'), { new_image: newURL })
  ,
  onError: (errorObj) ->
    alert(errorObj.message)

launchEditor = (id, src) ->
  featherEditor.launch
    image: id,
    url: src
  return false

$(document).on 'click', '[data-aviary]', ->
  image = $(this).parents('.item').find('img')
  return launchEditor(image.attr('id'), image.attr('data-image'))

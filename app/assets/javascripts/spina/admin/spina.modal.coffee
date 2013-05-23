# jQuery plugin
$.fn.modal = ->
  showModal($(this))

$(document).on 'click', 'a[data-toggle="modal"]', ->
  link = $(this)
  modal = $(link.attr('href'))
  showModal(modal)

$(document).on 'click', 'body.overlay', ->
  hideModal()

$(document).on 'click', 'a[data-dismiss="modal"]', ->
  hideModal()

$(document).on 'click', '.modal', (e) ->
  e.stopPropagation()

hideModal = ->
  $('body').removeClass('overlay')
  $('#overlay .modal').addClass('bounceOut')
  $('#overlay').fadeOut 300, ->
    $(this).remove()
  return false

showModal = (element) ->
  modal = element.clone()
  modal.addClass('animated flipInX')

  if $('#overlay').length < 1
    $('body').append('<div id="overlay"></div>')

  modal.css({"margin-top": -element.height()})

  modal.appendTo('#overlay')
  $('#overlay').fadeIn 200, ->
    modal.show()
    modal.animate({"margin-top": window.innerHeight / 8}, 200)

  $('body').addClass('overlay')
  return false
ready = ->
  # Bootstrap elements
  if $('nav#primary').length > 0
    $('body').prepend('<div id="navigation_panel" />')

  # Fill off-canvas navigation
  $('#navigation_panel').append($('nav#primary ul').clone())

  # Include secondary menu if available
  if $('nav#secondary').length > 0
    $('nav#secondary ul').clone().addClass('secondary').appendTo('#navigation_panel')
    $('#navigation_panel ul.secondary').prepend('<li class="divider" />')

  $('#navigation_panel a').attr('data-no-turbolink', true)

  # Disable double tap zoom
  $('body').doubletap (e) ->
    e.preventDefault()

$(document).ready(ready)
$(document).on('page:load', ready)

# Trigger
$(document).on 'click', 'a[data-toggle=navigation]', ->
  $('html').toggleClass('navigation-open')
  return false

# Close menu
$(document).on 'click', '.navigation-open #wrapper', ->
  closeNavigation()
$(document).on 'touchend', '.navigation-open #wrapper', ->
  closeNavigation()

openNavigation = ->
  $('html').addClass('navigation-open')
  return false

closeNavigation = ->
  $('html').removeClass('navigation-open')
  return false

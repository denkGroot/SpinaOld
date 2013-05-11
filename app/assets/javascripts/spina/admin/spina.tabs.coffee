$(document).on 'click', '.tabs li a', ->
  link = $(this)
  tabs = link.parent('.tabs')
  
  # Remove active
  $('.tab-content').removeClass('active')
  tabs.find('li').removeClass('active')

  # Add active
  link.parent('li').addClass('active')
  $(link.attr('href')).addClass('active')
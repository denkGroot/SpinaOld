$(document).on 'click', 'a[data-dismiss="notification"]', ->
  $(this).parent('.notification').fadeOut 200, ->
    $(this).remove()